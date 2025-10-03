import 'package:admincoffee/model/coffee.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Coffee coffee;

  const ProductCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      shadowColor: Colors.brown.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // Later: open product details page if needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Selected: ${coffee.name}")),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coffee image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: coffee.image != null
                  ? Image.memory(
                      coffee.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    )
                  : Container(
                      color: Colors.brown.shade50,
                      width: double.infinity,
                      height: 180,
                      child: const Icon(Icons.local_cafe, size: 70, color: Colors.brown),
                    ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coffee name
                  Text(
                    coffee.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Coffee description
                  Text(
                    coffee.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Price + Category Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₱${coffee.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      Chip(
                        label: Text(
                          coffee.category,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.brown,
                          ),
                        ),
                        backgroundColor: Colors.brown.shade100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
