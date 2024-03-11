import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';

import '../models/announcement_model.dart';
import '../models/category_item_model.dart';
import '../models/user_model.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> getProducts();
  Future<List<AnnouncementModel>> getAnnouncements();
  Future<List<CategoryModel>> getCategories();
}

class HomeServicesImpl implements HomeServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<ProductItemModel>> getProducts() async =>
      await firestoreService.getCollection<ProductItemModel>(
        path: ApiPaths.products(),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );

  Future<UserModel> getUserData(String userID) async =>
      await firestoreService.getDocument<UserModel>(
        path: ApiPaths.user(userID),
        builder: (data, documentID) {
          return UserModel.fromMap(data);
        },
      );

  Future<List<AnnouncementModel>> getAnnouncements() async =>
      await firestoreService.getCollection<AnnouncementModel>(
        path: ApiPaths.announcements(),
        builder: (data, documentID) {
          return AnnouncementModel.fromMap(data);
        },
      );

  Future<List<CategoryModel>> getCategories() async =>
      await firestoreService.getCollection<CategoryModel>(
        path: ApiPaths.categories(),
        builder: (data, documentID) {
          return CategoryModel.fromMap(data);
        },
      );
}
