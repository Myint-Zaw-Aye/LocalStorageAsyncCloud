import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_storage_async_cloud/model/user.dart';

final localDatabaseServiceProvider = Provider<LocalService>((ref) => LocalService());

class LocalService {
  static const _boxName = 'usersBox';

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    await Hive.openBox<User>(_boxName);
    await Hive.openBox<int>("counterBox");  
  }

  Box<User> get _box => Hive.box<User>(_boxName);
  Box<int> get _counterBox => Hive.box<int>("counterBox");

  List<User> getUsers() {
    return _box.values.toList();
  }

  Future<int> insertUser(User user) async {
    int lastId = _counterBox.get('user_last_id', defaultValue: 0)!;
    int newId = lastId + 1;
     _counterBox.put('user_last_id', newId);
     user.id = newId;
    await _box.put(newId, user);
    return newId;
  }

  Future<void> updateUser(User user) async {
    await _box.put(user.id, user);
  }

  Future<void> deleteUser(int id) async {
    await _box.delete(id);
  }
}
