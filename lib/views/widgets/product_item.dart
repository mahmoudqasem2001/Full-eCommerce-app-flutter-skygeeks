import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_models/favorite_product_cubit/favorite_product_cubit.dart';
import '../../view_models/favorite_product_cubit/favortite_product_state.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoriteProductCubit>(context);

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 110,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.grey2,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: productItem.imgUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: BlocBuilder<FavoriteProductCubit, FavoriteProductState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is FavoriteProductError ||
                    current is FavoriteProductLoaded ||
                    current is FavoriteProductLoading,
                builder: (context, state) {
                  if (state is FavoriteProductError) {
                    return const Center(child: Text("Error"));
                  } else if (state is FavoriteProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is FavoriteProductLoaded) {
                    final List<ProductItemModel> favoriteProducts =
                        state.favoriteProducts;

                    bool foundProduct = favoriteProducts
                        .any((element) => element.id == productItem.id);
                    return InkWell(
                      onTap: () {
                        if (foundProduct) {
                          cubit.removeFavoriteProduct(productItem.id);
                        } else {
                          cubit.addFavoriteProduct(productItem);
                        }
                      },
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            favoriteProducts.contains(productItem)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favoriteProducts.contains(productItem)
                                ? AppColors.red
                                : AppColors.white,
                            size: 17,
                          ),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      if (dummyFavorites.contains(productItem)) {
                        cubit.removeFavoriteProduct(productItem.id);
                      } else {
                        cubit.addFavoriteProduct(productItem);
                      }
                    },
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          dummyProducts.contains(productItem)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: dummyProducts.contains(productItem)
                              ? AppColors.red
                              : AppColors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          productItem.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          productItem.category,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
        Text(
          '\$${productItem.price}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
