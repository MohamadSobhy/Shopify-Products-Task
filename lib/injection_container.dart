import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/api/api_request_handler.dart';
import 'core/api/repository_calls_handler.dart';
import 'core/network/network_info.dart';
import 'features/shopify_products/data/datasources/shopify_products_remote_datasource.dart';
import 'features/shopify_products/data/repositories/shopify_products_repository_impl.dart';
import 'features/shopify_products/domain/repositories/shopify_products_repository.dart';
import 'features/shopify_products/domain/usecases/fetch_shopify_products_list.dart';
import 'features/shopify_products/presentation/bloc/shopify_products_bloc.dart';

final servLocator = GetIt.instance;

void initServLocator() {
  //! Core
  servLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  servLocator.registerLazySingleton(
    () => ApiBaseHandler(client: servLocator()),
  );
  servLocator.registerLazySingleton(
    () => RepositoryCallHandler(networkInfo: servLocator()),
  );

  //! Externals
  servLocator.registerLazySingleton(() => http.Client());

  //! Features

  //! Shopify Products Feature

  //! Blocs
  servLocator.registerFactory(
    () => ShopifyProductsBloc(fetchShopifyProductsList: servLocator()),
  );

  //! UseCases
  servLocator.registerLazySingleton(
    () => FetchShopifyProductsList(repository: servLocator()),
  );

  //! Repositories
  servLocator.registerLazySingleton<ShopifyProductsRepository>(
    () => ShopifyProductsRepositoryImpl(
      remoteDataSource: servLocator(),
      callHandler: servLocator(),
    ),
  );

  //! Data Sources
  servLocator.registerLazySingleton<ShopifyProductsRemoteDataSource>(
    () => ShopifyProductsRemoteDataSourceImpl(apiBaseHandler: servLocator()),
  );
}
