import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_async_cloud/screen/home_screen.dart';
import 'package:local_storage_async_cloud/service/local_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = LocalService();
  await hiveService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: UserListScreen(),
      ),
    );
  }
}
