import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductTagsListLoadingView extends StatelessWidget {
  const ProductTagsListLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 12,
      itemBuilder: (_, __) => const ProductsTagLoadingView(),
    );
  }
}

class ProductsTagLoadingView extends StatelessWidget {
  const ProductsTagLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: const ListTile(),
      ),
    );
  }
}
