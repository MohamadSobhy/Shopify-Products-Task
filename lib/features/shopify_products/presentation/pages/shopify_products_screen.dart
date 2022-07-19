import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/shopify_products_bloc.dart';
import '../widgets/products_tag_loading_view.dart';
import '../widgets/products_tags_view.dart';
import '../widgets/products_view.dart';

class ShopifyProductsScreen extends StatelessWidget {
  static const String routeName = '/shopify_products_screen';

  ShopifyProductsScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final StreamController<String?> _selectedProductsTagController =
      StreamController<String?>.broadcast();
  String? _selectedTag;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_pageController.page == 1) {
          _animatePageViewTo(page: 0);
          _selectedProductsTagController.add(null);

          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: StreamBuilder<String?>(
            stream: _selectedProductsTagController.stream,
            builder: (context, snapshot) {
              return Text(snapshot.data ?? 'Shopify Products');
            },
          ),
          centerTitle: true,
          leading: StreamBuilder<String?>(
            stream: _selectedProductsTagController.stream,
            builder: (context, snapshot) {
              return Visibility(
                visible: snapshot.data != null,
                child: IconButton(
                  onPressed: () {
                    _animatePageViewTo(page: 0);
                    _selectedProductsTagController.add(null);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              );
            },
          ),
        ),
        body: BlocBuilder<ShopifyProductsBloc, ShopifyProductsState>(
          builder: (context, state) {
            if (state is ShopifyProductsLoadingState) {
              return const ProductTagsListLoadingView();
            } else if (state is ShopifyProductsServerErrorState) {
              //! Can show custom netowrk error design here
              return Center(
                child: Text(state.message, textAlign: TextAlign.center),
              );
            } else if (state is ShopifyProductsNetworkErrorState) {
              //! Can show custom server error design here
              return Center(
                child: Text(state.message, textAlign: TextAlign.center),
              );
            } else if (state is ShopifyProductsFetchedState) {
              return PageView(
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  ProductsTagsView(
                    tags: state.response.tags,
                    onTagSelected: (String tag) {
                      _selectedTag = tag;

                      _animatePageViewTo(page: 1);
                      _selectedProductsTagController.add(_selectedTag);
                    },
                  ),
                  AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, snapshot) {
                      return ProductsView(
                        products: state.response.products
                            .where(
                              (element) =>
                                  element.tags.contains(_selectedTag ?? ''),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  void _animatePageViewTo({int page = 0}) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
