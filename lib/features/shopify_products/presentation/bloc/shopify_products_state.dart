part of 'shopify_products_bloc.dart';

abstract class ShopifyProductsState extends Equatable {
  const ShopifyProductsState();

  @override
  List<Object?> get props => [];
}

class ShopifyProductsLoadingState extends ShopifyProductsState {}

class ShopifyProductsServerErrorState extends ShopifyProductsState {
  final String message;

  const ShopifyProductsServerErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ShopifyProductsNetworkErrorState extends ShopifyProductsState {
  final String message;

  const ShopifyProductsNetworkErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ShopifyProductsFetchedState extends ShopifyProductsState {
  final ProductsResponse response;

  const ShopifyProductsFetchedState({required this.response});

  @override
  List<Object?> get props => [response];
}
