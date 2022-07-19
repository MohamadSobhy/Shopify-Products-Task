import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/products_response.dart';
import '../../domain/usecases/fetch_shopify_products_list.dart';

part 'shopify_products_event.dart';
part 'shopify_products_state.dart';

class ShopifyProductsBloc
    extends Bloc<ShopifyProductsEvent, ShopifyProductsState> {
  FetchShopifyProductsList fetchShopifyProductsList;

  ShopifyProductsBloc({
    required this.fetchShopifyProductsList,
  }) : super(ShopifyProductsLoadingState()) {
    on<ShopifyProductsEvent>((event, emit) async {
      emit(ShopifyProductsLoadingState());

      final result = await fetchShopifyProductsList(NoParams());

      result.fold(
        (failure) {
          if (failure is NetworkFailure) {
            emit(ShopifyProductsNetworkErrorState(message: failure.message));
          } else {
            emit(ShopifyProductsServerErrorState(message: failure.message));
          }
        },
        (response) => emit(ShopifyProductsFetchedState(response: response)),
      );
    });
  }
}
