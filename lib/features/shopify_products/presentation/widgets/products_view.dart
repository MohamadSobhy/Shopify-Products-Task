import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductsView extends StatelessWidget {
  final List<Product> products;

  const ProductsView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        if (products[index].images.isNotEmpty) {
          return Card(
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return PageView.builder(
                      itemCount: products[index].images.length,
                      itemBuilder: (_, i) {
                        return CachedNetworkImage(
                          imageUrl: products[index].images[i],
                        );
                      },
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        height: 100,
                        width: 100,
                        imageUrl: products[index].images.first,
                      ),
                      // if (products[index].images.length > 1)
                      //! Display number of image of the product
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black26,
                        ),
                        child: Text(
                          'x${products[index].images.length}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Inventory QTY: ${products[index].inventoryQuantity}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListTile(
          title: Text(products[index].title),
        );
      },
    );
  }
}
