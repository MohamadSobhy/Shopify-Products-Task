import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/shopify_products_bloc.dart';

class ProductsTagsView extends StatelessWidget {
  final List<String> tags;
  final Function(String)? onTagSelected;

  const ProductsTagsView({Key? key, required this.tags, this.onTagSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<ShopifyProductsBloc>(context)
            .add(FetchMyShopifyProductsEvent());

        return Future.value();
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
        itemCount: tags.length,
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              onTap: onTagSelected == null
                  ? null
                  : () => onTagSelected!(tags[index]),
              title: Text(
                tags[index],
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
