import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー画面'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 一つ前の画面に戻る
          },
        ),
      ),
      body: Column(
        children: [
          // 検索バー
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'ユーザー検索',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchQuery = _searchController.text.trim();
                    });
                  },
                ),
              ),
            ),
          ),
          // ユーザー一覧
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .orderBy('driver_id')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return data['driver_id']?.toString().contains(_searchQuery) == true ||
                      data['driver_name']?.toString().contains(_searchQuery) == true ||
                      data['company_code']?.toString().contains(_searchQuery) == true ||
                      data['company_name']?.toString().contains(_searchQuery) == true;
                }).toList();

                if (users.isEmpty) {
                  return const Center(child: Text('ユーザーが見つかりません'));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final userDoc = users[index];
                    return ListTile(
                      title: Text(userDoc['driver_id'] ?? '不明'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '運転手: ${(userDoc.data() as Map<String, dynamic>?)?['driver_name'] ?? '未登録'}',
                          ),
                          Text(
                            '運送会社コード: ${(userDoc.data() as Map<String, dynamic>?)?['company_code'] ?? '未登録'}',
                          ),
                          Text(
                            '運送会社名: ${(userDoc.data() as Map<String, dynamic>?)?['company_name'] ?? '未登録'}',
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'show_password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('パスワード: ${userDoc['password'] ?? '不明'}')),
                            );
                          } else if (value == 'delete') {
                            _deleteUser(userDoc.id);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'show_password',
                            child: Text('パスワード表示'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('削除'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // ユーザー登録ボタン
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _showAddUserDialog,
              child: const Text('ユーザー登録'),
            ),
          ),
        ],
      ),
    );
  }

  void _showPassword(String password) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('パスワード'),
        content: Text(password),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ユーザーを削除しました')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラー: $e')),
      );
    }
  }

  void _showAddUserDialog() {
    final TextEditingController driverIdController = TextEditingController();
    final TextEditingController driverNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController companyCodeController = TextEditingController();
    final TextEditingController companyNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ユーザー登録'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: driverIdController,
                  decoration: const InputDecoration(labelText: 'ドライバーID'),
                ),
                TextField(
                  controller: driverNameController,
                  decoration: const InputDecoration(labelText: '運転手'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                ),
                TextField(
                  controller: companyCodeController,
                  decoration: const InputDecoration(labelText: '運送会社コード'),
                ),
                TextField(
                  controller: companyNameController,
                  decoration: const InputDecoration(labelText: '運送会社名'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance.collection('users').add({
                    'driver_id': driverIdController.text.trim(),
                    'driver_name': driverNameController.text.trim(),
                    'password': passwordController.text.trim(),
                    'company_code': companyCodeController.text.trim(),
                    'company_name': companyNameController.text.trim(),
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ユーザーを登録しました')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('エラー: $e')),
                  );
                }
              },
              child: const Text('登録'),
            ),
          ],
        );
      },
    );
  }
}
