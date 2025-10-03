import 'package:admincoffee/model/coffee.dart';
import 'package:admincoffee/view/card/product_card.dart';
import 'package:flutter/material.dart';

class AllProductsPage extends StatelessWidget {
  final List<Coffee> products;

  const AllProductsPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
        backgroundColor: Colors.brown,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(coffee: products[index]);
        },
      ),
    );
  }
}
