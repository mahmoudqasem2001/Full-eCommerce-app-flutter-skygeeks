import 'package:ecommerce_app/models/product_item_model.dart';

sealed class FavoriteProductState {}

final class FavoriteProductInitial extends FavoriteProductState {}

final class FavoriteProductLoading extends FavoriteProductState {}

final class FavoriteProductLoaded extends FavoriteProductState {
  final List<ProductItemModel> favoriteProducts;

  FavoriteProductLoaded({required this.favoriteProducts});
}

final class FavoriteProductError extends FavoriteProductState {
  final String error;

  FavoriteProductError({required this.error});
}
