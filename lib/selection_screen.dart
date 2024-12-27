import 'package:flutter/material.dart';
import 'user_screen.dart';
import 'api_test_screen.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('選択画面'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserScreen()),
                );
              },
              child: const Text('ユーザー管理'),
            ),
            const SizedBox(height: 20), // ボタン間のスペース
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApiTestScreen()),
                );
              },
              child: const Text('APIテスト'),
            ),
          ],
        ),
      ),
    );
  }
}
