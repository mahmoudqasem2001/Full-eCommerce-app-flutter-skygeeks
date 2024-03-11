import 'package:ecommerce_app/view_models/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/home_services.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getUserData() async {
    try {
      emit(ProfileLoading());
      final homeServices = HomeServicesImpl();

      await Future.delayed(const Duration(seconds: 1));
      final userData =
          await homeServices.getUserData("rh4luwu7j8MtRfjduGT13nz33Ri2");
      print(userData.email);
      emit(ProfileLoaded(user: userData));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }
}
