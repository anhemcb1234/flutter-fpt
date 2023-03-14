import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_app/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Widget gotoHome(BuildContext context) {
    return const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    void onLogOut() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (const MyApp())));
      final storage = FlutterSecureStorage();
      await storage.delete(key: 'token');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: onLogOut,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.info),
                  title: Text('Item $index'),
                  subtitle: Text('This is item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
