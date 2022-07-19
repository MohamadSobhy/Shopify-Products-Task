import '../../domain/entities/product.dart';
import '../../domain/entities/products_response.dart';
import 'product_model.dart';

class ProductsResponseModel extends ProductsResponse {
  const ProductsResponseModel({
    required List<String> tags,
    required List<Product> products,
  }) : super(tags: tags, products: products);

  factory ProductsResponseModel.fromJson(Map<String, dynamic> parsedJson) {
    final prodsJson = parsedJson['products'] as List<dynamic>;

    final products =
        prodsJson.map((json) => ProductModel.fromJson(json)).toList();

    List<String> tags = [];

    for (final product in products) {
      tags.addAll(product.tags.split(", "));
    }

    return ProductsResponseModel(
      tags: tags.toSet().toList(),
      products: products,
    );
  }

  @override
  List<Object?> get props => [tags, products];
}
