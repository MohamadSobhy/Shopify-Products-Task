import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/products_response.dart';

abstract class ShopifyProductsRepository {
  Future<Either<Failure, ProductsResponse>> fetchMyShopifyProductsList();
}
