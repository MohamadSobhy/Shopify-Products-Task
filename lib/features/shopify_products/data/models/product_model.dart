import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required num id,
    required String title,
    required String bodyHtml,
    required String vendor,
    required String productType,
    required String status,
    required String tags,
    required List<String> images,
    required int inventoryQuantity,
  }) : super(
          id: id,
          title: title,
          bodyHtml: bodyHtml,
          vendor: vendor,
          productType: productType,
          status: status,
          tags: tags,
          images: images,
          inventoryQuantity: inventoryQuantity,
        );

  factory ProductModel.fromJson(Map<String, dynamic> parsedJson) {
    List<String> prodImages = [];

    if (parsedJson['images'] != null) {
      prodImages = List<String>.from(
        parsedJson['images'].map((imageJson) => imageJson['src'].toString()),
      );
    }

    int invQuantity = 0;

    final variantsJson = parsedJson['variants'] as List<dynamic>? ?? [];

    for (final variant in variantsJson) {
      invQuantity += (variant['inventory_quantity'] as int?) ?? 0;
    }

    return ProductModel(
      id: parsedJson['id'],
      title: parsedJson['title'],
      bodyHtml: parsedJson['body_html'],
      vendor: parsedJson['vendor'],
      productType: parsedJson['product_type'],
      status: parsedJson['status'],
      tags: parsedJson['tags'],
      images: List<String>.from(prodImages),
      inventoryQuantity: invQuantity,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, bodyHtml, vendor, productType, status, tags, images];
}
