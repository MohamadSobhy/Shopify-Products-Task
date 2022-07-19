import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/shopify_products/presentation/bloc/shopify_products_bloc.dart';
import 'features/shopify_products/presentation/pages/shopify_products_screen.dart';
import 'injection_container.dart';

void main() {
  initServLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final shopifyProductsBloc = servLocator<ShopifyProductsBloc>();
            shopifyProductsBloc.add(FetchMyShopifyProductsEvent());

            return shopifyProductsBloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ShopifyProductsScreen(),
      ),
    );
  }
}
