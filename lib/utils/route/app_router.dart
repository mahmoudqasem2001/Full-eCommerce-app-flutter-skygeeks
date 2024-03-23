
import 'package:ecommerce_app/utils/route/app_routes.dart';
import 'package:ecommerce_app/views/pages/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_item_model.dart';
import '../../view_models/checkout_cubit/checkout_cubit.dart';
import '../../view_models/favorite_product_cubit/favorite_product_cubit.dart';
import '../../view_models/home_cubit/home_cubit.dart';
import '../../view_models/product_details_cubit/product_details_cubit.dart';
import '../../view_models/profile_cubit/profile_cubit.dart';
import '../../views/pages/checkout_page.dart';
import '../../views/pages/login_page.dart';
import '../../views/pages/product_details_page.dart';
import '../../views/pages/profle_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final homeCubit = HomeCubit();
    final userDataCubit = ProfileCubit();
    final favoriteProductCubit = FavoriteProductCubit();
    final productDetailsCubit = ProductDetailsCubit();

    switch (settings.name) {
      case AppRoutes.bottomNavbar:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  homeCubit.getHomeData();
                  return homeCubit;
                },
              ),
              BlocProvider(
                create: (context) {
                  favoriteProductCubit.getFavoriteProducts();
                  return favoriteProductCubit;
                },
              ),
            ],
            child: const CustomBottomNavbar(),
          ),
          settings: settings,
        );
      case AppRoutes.productDetails:
        favoriteProductCubit.getFavoriteProducts();
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  final product = settings.arguments as ProductItemModel;
                  final productId = product.id;
                  productDetailsCubit.getProductDetails(productId);
                  return productDetailsCubit;
                },
              ),
              BlocProvider.value(
                value: favoriteProductCubit,
              ),
            ],
            child: const ProductDetailsPage(),
          ),
          settings: settings,
        );
      case AppRoutes.homeLogin:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginPage();
          },
        );
      
      case AppRoutes.checkoutPage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) {
                final cubit = CheckoutCubit();
                cubit.getCheckoutPage();

                return cubit;
              },
              child: const CheckoutPage(),
            );
          },
        );
      case AppRoutes.profilePage:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) {
                userDataCubit.getUserData();
                return userDataCubit;
              },
              child: const ProfilePage(),
            );
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }
}