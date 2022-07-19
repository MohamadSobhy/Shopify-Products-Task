import '../../../../core/api/api_request_handler.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/products_response_model.dart';

abstract class ShopifyProductsRemoteDataSource {
  Future<ProductsResponseModel> fetchMyShopifyProductsList();
}

class ShopifyProductsRemoteDataSourceImpl
    implements ShopifyProductsRemoteDataSource {
  final ApiBaseHandler apiBaseHandler;

  ShopifyProductsRemoteDataSourceImpl({required this.apiBaseHandler});

  @override
  Future<ProductsResponseModel> fetchMyShopifyProductsList() async {
    final parsedJson =
        await apiBaseHandler.get(ApiEndpoints.shopifyProductsEndpointUrl);

    return ProductsResponseModel.fromJson(parsedJson);
  }
}
