import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

import '../models/product_item_model.dart';

abstract class FavoriteServices {
  Future<List<ProductItemModel>> getFavProducts();
  Future<void> addFavProduct();
  Future<void> removeFavProduct();
}

class FavoriteServicesImpl {
  final firestoreService = FirestoreService.instance;
  Future<List<ProductItemModel>> getProducts(String uid) async {
    return await firestoreService.getCollection<ProductItemModel>(
      path: ApiPaths.favProducts(uid),
      builder: (data, documentID) {
        return ProductItemModel.fromMap(data, documentID);
      },
    );
  }

  Future<void> addFavProducts(String uid, ProductItemModel favProduct) async {
    return await firestoreService.setData(
      path: ApiPaths.favProduct(uid, favProduct.id),
      data: favProduct.toMap(),
    );
  }

  Future<void> removeFavProduct(String uid, String productId) async {
    return await firestoreService.deleteData(
      path: ApiPaths.favProduct(uid, productId),
    );
  }
}
