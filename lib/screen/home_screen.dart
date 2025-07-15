import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_storage_async_cloud/provider/user_provider.dart';
import 'package:local_storage_async_cloud/screen/user_detail.dart';
import 'package:local_storage_async_cloud/screen/user_form.dart' show UserFormScreen;
import 'package:local_storage_async_cloud/screen/user_search_delegate.dart';

class UserListScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // Call only once after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 5, 156, 145),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: UserSearchDelegate(users),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Card(
              child: ListTile(
                title: Text(user.name),
                subtitle: Column(
                  children: [
                    Text(
                        '${user.email} - ${user.phoneNumber} '),
                    if (user.isSynced)
                      Text(
                        'Synced',
                        style: TextStyle(color: Colors.green),
                      ) 
                    else
                      Text(
                        'Not Synced',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 5, 156, 145),
                      ),
                      onPressed: () =>
                          userNotifier.updateUser(user),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => userNotifier
                          .deleteUser(user.id!),

                      // onPressed: () => _deleteAppointment(appointment.id!),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          UserDetailScreen(user: user),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 5, 156, 145),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UserFormScreen(),
            ),
          );
        },
      ),
    );
  }
}
