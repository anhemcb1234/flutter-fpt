import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String name;
  final String image;
  final int quantity;
  final double price;

  CartItem({required this.name, required this.image, required this.quantity, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Quantity: $quantity',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
