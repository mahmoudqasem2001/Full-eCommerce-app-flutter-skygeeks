import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/favorite_services.dart';
import 'favortite_product_state.dart';

class FavoriteProductCubit extends Cubit<FavoriteProductState> {
  FavoriteProductCubit() : super(FavoriteProductInitial());
  final favoriteServicesImpl = FavoriteServicesImpl();

  final firebaseAuth = FirebaseAuth.instance;

  void getFavoriteProducts() async {
    try {
      emit(FavoriteProductLoading());

      final List<ProductItemModel> products =
          await favoriteServicesImpl.getProducts(firebaseAuth.currentUser!.uid);
      emit(FavoriteProductLoaded(favoriteProducts: products));
    } catch (e) {
      emit(FavoriteProductError(error: e.toString()));
    }
  }

  void addFavoriteProduct(ProductItemModel favProduct) async {
    favoriteServicesImpl.addFavProducts(
        firebaseAuth.currentUser!.uid, favProduct);
   
    getFavoriteProducts();
  }

  void removeFavoriteProduct(String productId) async {
    favoriteServicesImpl.removeFavProduct(
        firebaseAuth.currentUser!.uid, productId);
    getFavoriteProducts();
  }
}
