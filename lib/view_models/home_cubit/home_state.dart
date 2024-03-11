part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  HomeLoaded({
    required this.products,
    required this.announcement,
    required this.categories,
  });

  final List<ProductItemModel> products;
  final List<AnnouncementModel> announcement;
  final List<CategoryModel> categories;
}

final class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}