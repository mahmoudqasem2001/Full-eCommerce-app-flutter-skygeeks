import 'package:ecommerce_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.signInWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Failed to sign in'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.signUpWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Failed to sign up'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authServices.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    try {
      final user = await authServices.currentUser();
      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    emit(AuthLoading());
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(AuthFailure('No user signed in'));
        return;
      }

      await authServices.updateUserPhoneNumber(currentUser.uid, phoneNumber);

      emit(AuthSuccess(user: currentUser));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
