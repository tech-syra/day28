import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '/product',
          extra: product,
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              Text(
                '₹${product.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}