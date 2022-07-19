import 'package:equatable/equatable.dart';

abstract class Product extends Equatable {
  final num id;
  final String title;
  final String bodyHtml;
  final String vendor;
  final String productType;
  final String status;
  final String tags;
  final List<String> images;
  final int inventoryQuantity;

  const Product({
    required this.id,
    required this.title,
    required this.bodyHtml,
    required this.vendor,
    required this.productType,
    required this.status,
    required this.tags,
    required this.images,
    required this.inventoryQuantity,
  });
}
