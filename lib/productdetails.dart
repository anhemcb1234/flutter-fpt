import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_app/main.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class Product {
  final String createdDate;
  final double category;
  final double description;
  final double id;
  final double img;
  final double modifiedDate;
  final double name;
  final double price;
  final double quantity;
  final double status;

  Product(
    this.createdDate,
    this.category,
    this.description,
    this.id,
    this.img,
    this.modifiedDate,
    this.name,
    this.price,
    this.quantity,
    this.status,
  );
}

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.productId});
  final String productId;
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
    _loadProductDetail();
  }

  String name = '';
  int price = 0;
  int quantity = 0;
  String desc = '';
  int _count = 1;

  Future _loadProductDetail() async {
    var id = widget.productId;
    final url =
        Uri.parse('https://mobile-project.herokuapp.com/product/byId/$id');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    setState(() {
      name = jsonDecode(utf8.decode(response.bodyBytes))['data']['name'];
      price = jsonDecode(utf8.decode(response.bodyBytes))['data']['price'];
      quantity = jsonDecode(utf8.decode(response.bodyBytes))['data']['quantity'];
      desc = jsonDecode(utf8.decode(response.bodyBytes))['data']['description'];
    });
  }

  Future onClickOrder() async {
    print('Buy');
  }

  void _incrementCount() {
    setState(() {
      if (_count < quantity) {
        _count++;
      }
    });
  }

  void _decrementCount() {
    setState(() {
      if (_count > 1 && _count <= quantity) {
        _count--;
      }
    });
  }

  Widget gotoHome(BuildContext context) {
    return const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://th.bing.com/th/id/OIP.3y1YXD6H0_f8cTgGdj9T3AHaE7?pid=ImgDet&rs=1',
              fit: BoxFit.cover,
              height: 300,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name $name',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Price $price',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Quantity $quantity',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$desc',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: _decrementCount,
                        child: const Icon(Icons.remove),
                      ),
                      Text('Current count: $_count'),
                      FloatingActionButton(
                        onPressed: _incrementCount,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickOrder,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.shop),
      ),
    );
  }
}
