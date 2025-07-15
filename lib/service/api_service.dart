
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:local_storage_async_cloud/model/user.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());


final String baseUrl = kIsWeb
    ? 'http://localhost:3000'
    : Platform.isAndroid
        ? 'http://10.0.2.2:3000'
        : 'http://localhost:3000'; // for Windows, macOS, iOS simulator
    
class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  //http://192.168.100.224:3000/appointments

  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('/users');
    return (response.data as List)
        .map((json) => User.fromJson(json))
        .toList();
  }

  Future<String> syncUsers(User user) async {
    try {
      user.isSynced = true;
             await _dio.post('/users', data: user.toJson());
      // if (user.id == null) {
      //  await _dio.post('/users', data: user.toJson());
      // } else {
      //   await _dio.put('/users/${user.id}', data: user.toJson());
      // }
      return "success";
    } catch (e) {
       user.isSynced = false;
      // Handle error, e.g., log it or rethrow        
      print('Error syncing user: $e');
      return "failed";  
    }
  }

}
