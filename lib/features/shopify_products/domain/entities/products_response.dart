import 'package:equatable/equatable.dart';

import 'product.dart';

abstract class ProductsResponse extends Equatable {
  final List<String> tags;
  final List<Product> products;

  const ProductsResponse({required this.tags, required this.products});
}
