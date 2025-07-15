import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_async_cloud/model/user.dart';
import '../service/api_service.dart';
import '../service/local_service.dart';

final userProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  return UserNotifier(ref);
});

class UserNotifier extends StateNotifier<List<User>> {
  final Ref ref;

  UserNotifier(this.ref) : super([]);

  Future<void> loadUsers() async {
    final users = await ref.read(localDatabaseServiceProvider).getUsers();
    state = users;
    syncWithApi();
  }

  Future<void> addUser(User user) async {
    final id = await ref.read(localDatabaseServiceProvider).insertUser(user);
    state = [...state, user..id = id];
    user.id = id;
    syncUserWithApi(user);
  }

  Future<void> updateUser(User user) async {
    await ref.read(localDatabaseServiceProvider).updateUser(user);
    state = [
      for (final a in state)
        if (a.id == user.id) user else a,
    ];
    syncWithApi();
  }

  Future<void> deleteUser(int id) async {
    await ref.read(localDatabaseServiceProvider).deleteUser(id);
    state = state.where((a) => a.id != id).toList();
    syncWithApi();
  }

  Future<void> syncWithApi() async {
    final apiService = ref.read(apiServiceProvider);
    final localUsers = ref.read(localDatabaseServiceProvider).getUsers();

    try {
      var result = await Connectivity().checkConnectivity();
      if (result.contains(ConnectivityResult.none))  {
        return; // No internet connection, skip syncing
      }

      for (final localUser in localUsers.where((u) => !u.isSynced)) {
        // localUser.isSynced = true;
        String result = await apiService.syncUsers(localUser);
        // Mark as synced
        if (result == "success") {
          localUser.isSynced = true;
          await ref.read(localDatabaseServiceProvider).updateUser(localUser);
        }
      }
    } catch (e) {
      return;
    }

    final remoteUsers = await apiService.fetchUsers();
    state = remoteUsers;
  }

  Future<void> syncUserWithApi(User user) async {
    final apiService = ref.read(apiServiceProvider);
    // user.isSynced = true;

    try {
      List<ConnectivityResult> result = await Connectivity().checkConnectivity();
      if (result.contains(ConnectivityResult.none)) {
        return; // No internet connection, skip syncing
      }
      // Sync user with API
      String resultData = await apiService.syncUsers(user);
      // Mark as synced
      if (resultData == "success") {
        user.isSynced = true;
        await ref.read(localDatabaseServiceProvider).updateUser(user);
      }
      final remoteUsers = await apiService.fetchUsers();
      state = remoteUsers;
    } catch (e) {
      return; // Handle any errors that occur during connectivity check
    }
  }
}
