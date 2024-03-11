import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/route/app_routes.dart';
import '../../view_models/favorite_product_cubit/favorite_product_cubit.dart';
import '../../view_models/favorite_product_cubit/favortite_product_state.dart';
import '../widgets/product_item.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoriteProductCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favorite Items",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: "Search something...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<FavoriteProductCubit, FavoriteProductState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is FavoriteProductError ||
                    current is FavoriteProductLoaded ||
                    current is FavoriteProductLoading,
                builder: (context, state) {
                  if (state is FavoriteProductError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else if (state is FavoriteProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is FavoriteProductLoaded) {
                    final favoriteProducts = state.favoriteProducts;
                    return GridView.builder(
                      itemCount: favoriteProducts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.82,
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              AppRoutes.productDetails,
                              arguments: product,
                            )
                                .then((value) {
                              cubit.getFavoriteProducts();
                            });
                          },
                          child: ProductItem(productItem: product),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
