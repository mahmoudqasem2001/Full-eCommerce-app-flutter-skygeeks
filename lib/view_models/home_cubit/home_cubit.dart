import 'package:ecommerce_app/models/announcement_model.dart';
import 'package:ecommerce_app/models/product_item_model.dart';
import 'package:ecommerce_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/category_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.getProducts();
      final List<AnnouncementModel> announcement =
          await homeServices.getAnnouncements();

      final List<CategoryModel> categories = await homeServices.getCategories();

      emit(HomeLoaded(
          products: products,
          announcement: announcement,
          categories: categories));
    } catch (e) {
      emit(HomeError( e.toString()));
    }
  }
}
