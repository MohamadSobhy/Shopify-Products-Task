import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/products_response.dart';
import '../repositories/shopify_products_repository.dart';

class FetchShopifyProductsList extends UseCase<NoParams, ProductsResponse> {
  final ShopifyProductsRepository repository;

  FetchShopifyProductsList({required this.repository});

  @override
  Future<Either<Failure, ProductsResponse>> call(params) {
    return repository.fetchMyShopifyProductsList();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
