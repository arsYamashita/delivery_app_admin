import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  _ApiTestScreenState createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  List<Map<String, dynamic>> orders = [];
  bool isLoading = false;

  // API からデータを取得
  Future<void> fetchOrders() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://getorders-4t2b2kn7va-uc.a.run.app/'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          orders = data.map((e) => e as Map<String, dynamic>).toList();
        });
      } else {
        throw Exception("Failed to load orders");
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("エラー: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // TimestampをDateTimeに変換するヘルパー関数
  DateTime? convertTimestamp(Map<String, dynamic>? timestamp) {
    if (timestamp == null) return null;
    int seconds = timestamp['_seconds'] ?? 0;
    int nanoseconds = timestamp['_nanoseconds'] ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(
      seconds * 1000 + nanoseconds ~/ 1000000, // ミリ秒単位に変換
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API テスト画面'),
      ),
      body: Column(
        children: [
          // APIを呼び出すボタン
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: fetchOrders,
              child: const Text('Get Orders'),
            ),
          ),
          // ローディング中の場合
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
          // データがない場合
          if (!isLoading && orders.isEmpty)
            const Center(child: Text('データがありません')),
          // データがある場合
          if (!isLoading && orders.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text('Order ID: ${order['id'] ?? '不明'}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Code: ${order['orderCode'] ?? '不明'}'),
                        Text('Package Name: ${order['packageName'] ?? '不明'}'),
                        Text('Quantity: ${order['quantity'] ?? 0}'),
                        Text('Status: ${order['status'] ?? '不明'}'),
                        Text('Store Name: ${order['storeName'] ?? '不明'}'),
                        Text('Store ID: ${order['storeId'] ?? '不明'}'),
                        Text('Driver ID: ${order['driverId'] ?? '不明'}'),
                        Text('Driver Name: ${order['driverName'] ?? '不明'}'),
                        Text('Registration Date: ${convertTimestamp(order['registrationDate'])?.toString() ?? '不明'}'),
                        Text('Picking Date: ${convertTimestamp(order['pickingDate'])?.toString() ?? '不明'}'),
                        Text('Complete Date: ${convertTimestamp(order['completeDate'])?.toString() ?? '不明'}'),
                        Text('Barcodes: ${order['barcodes']?.join(', ') ?? '不明'}'),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
