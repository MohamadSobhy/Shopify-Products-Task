import 'package:dartz/dartz.dart';

import '../../../../core/api/repository_calls_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/products_response.dart';
import '../../domain/repositories/shopify_products_repository.dart';
import '../datasources/shopify_products_remote_datasource.dart';

class ShopifyProductsRepositoryImpl implements ShopifyProductsRepository {
  final RepositoryCallHandler callHandler;
  final ShopifyProductsRemoteDataSource remoteDataSource;

  ShopifyProductsRepositoryImpl({
    required this.callHandler,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ProductsResponse>> fetchMyShopifyProductsList() {
    return callHandler.handleCall<ProductsResponse>(
      () => remoteDataSource.fetchMyShopifyProductsList(),
    );
  }
}
