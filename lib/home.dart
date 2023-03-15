import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_app/main.dart';
import 'package:intl/intl.dart';
import 'package:project_app/productdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  List products = [];

  Future _loadProducts() async {
    // final products = await ProductService.fetchProducts();
    final url = Uri.parse('https://mobile-project.herokuapp.com/product/list');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    setState(() {
      products = jsonDecode(utf8.decode(response.bodyBytes))['data'];
    });
    print(response.body);
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = jsonDecode(response.body);
    //   List<Product> products = [];
    //   data.forEach((product) {
    //     products.add(Product.fromJson(product));
    //   });
    //   return products;
    // } else {
    //   throw Exception('Failed to load products');
    // }
    // setState(() {
    //   products = data as List<Product>;
    // });
  }

  void onClickToDetailProduct(int productId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetail(productId: '$productId')));
  }

  Widget gotoHome(BuildContext context) {
    return const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    String _searchQuery = '';
    void onLogOut() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (const MyApp())));
      // final storage = FlutterSecureStorage();
      // await storage.delete(key: 'token');
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
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {_searchQuery = value},
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => onClickToDetailProduct(products[index]['id']),
                  leading: Image.network(products[index]['img'] ??
                      'https://th.bing.com/th/id/OIP.3y1YXD6H0_f8cTgGdj9T3AHaE7?pid=ImgDet&rs=1'),
                  title: Text(
                    products[index]['name'],
                  ),
                  subtitle: Text(
                    products[index]['description'],
                  ),
                  trailing: Text('\$${products[index]['price']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Type gotoProductDetail(BuildContext context) {
    return ProductDetail;
  }
}

// }
