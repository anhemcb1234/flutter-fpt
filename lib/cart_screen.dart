import 'dart:convert';
import 'package:project_app/home.dart';
import 'package:flutter/material.dart';
import 'package:project_app/cart_item.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    _loadListOrder();
  }

  List products = [];
  int total = 0;
  Future _loadListOrder() async {
    // var id = widget.productId;
    final url = Uri.parse('https://mobile-project.herokuapp.com/order/byId/2');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    setState(() {
      products = jsonDecode(utf8.decode(response.bodyBytes))['orderDetailList'];
      total = jsonDecode(utf8.decode(response.bodyBytes))['total'];
    });
    print(products);
  }

  Future onClickToOrder() async {
    // var id = widget.productId;
    final url = Uri.parse('https://mobile-project.herokuapp.com/user/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "email": '_email',
      "password": '_password',
    });
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (HomePage())));
    }

    // setState(() {
    //   products = jsonDecode(utf8.decode(response.bodyBytes))['orderDetailList'];
    //   total = jsonDecode(utf8.decode(response.bodyBytes))['total'];
    // });
    // print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Image.network(products[index]['product']['img'] ??
                      'https://th.bing.com/th/id/OIP.3y1YXD6H0_f8cTgGdj9T3AHaE7?pid=ImgDet&rs=1'),
                  title: Text(
                    products[index]['product']['name'],
                  ),
                  subtitle: Text(
                    products[index]['product']['description'],
                  ),
                  trailing: Text(
                      '\$${products[index]['price']} \n Quantity:${products[index]['quantity']}'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 64,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: $total'),
              ElevatedButton(
                onPressed: onClickToOrder,
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
