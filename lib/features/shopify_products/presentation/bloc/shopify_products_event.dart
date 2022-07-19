part of 'shopify_products_bloc.dart';

abstract class ShopifyProductsEvent extends Equatable {
  const ShopifyProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyShopifyProductsEvent extends ShopifyProductsEvent {}
