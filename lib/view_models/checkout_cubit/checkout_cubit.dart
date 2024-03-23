import 'package:ecommerce_app/models/address_model.dart';
import 'package:ecommerce_app/models/cart_orders_model.dart';
import 'package:ecommerce_app/models/payment_method_model.dart';
import 'package:ecommerce_app/services/auth_services.dart';
import 'package:ecommerce_app/services/checkout_services.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/utils/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkoutServices = CheckoutServicesImpl();
  final authServices = AuthServicesImpl();
  FirestoreService firestoreService = FirestoreService.instance;

  Future<void> getCheckoutPage() async {
    emit(CheckoutLoading());
    try {
      final currentUser = await authServices.currentUser();
      final cartItems = await checkoutServices.getCartItems(currentUser!.uid);
      final preferredLocation = (await checkoutServices.getAddresses(
        currentUser.uid,
        fetchPreferred: true,
      ))
          .first;
                

      final preferredPaymentMethod = (await checkoutServices.getPaymentMethods(
        currentUser.uid,
        fetchPreferred: true,
      ))
          .first;
          print(preferredPaymentMethod.cardNumber);
      final subtotal = cartItems.fold<double>(
          0,
          (sum, cartItem) =>
              sum + (cartItem.product.price * cartItem.quantity));
      final addresses = await checkoutServices
          .getAddresses((await authServices.currentUser())!.uid);
      final preferredAddress = addresses.firstWhere((element) => element.isFav);
      final paymentMethods = await checkoutServices
          .getPaymentMethods((await authServices.currentUser())!.uid);

      emit(
        CheckoutLoaded(
          cartItems: cartItems,
          preferredLocation: preferredLocation,
          preferredPaymentMethod: preferredPaymentMethod,
          totalAmount: subtotal + 10,
          addresses: addresses,
          address: preferredAddress,
          paymentMethods: paymentMethods,
        ),
      );
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }

  Future<void> setAddress(String addressName) async {
    final addresses = await checkoutServices
        .getAddresses((await authServices.currentUser())!.uid);
    addresses.forEach((e) async {
      if (e.name == addressName) {
        e = e.copyWith(isFav: true);
        await firestoreService.setData(
            path:
                ApiPaths.address((await authServices.currentUser())!.uid, e.id),
            data: e.toMap());
      } else {
        e = e.copyWith(isFav: false);
        await firestoreService.setData(
            path:
                ApiPaths.address((await authServices.currentUser())!.uid, e.id),
            data: e.toMap());
      }
    });
  }

  Future<void> setPaymentMethod(String? paymentMethodName) async {
    if (paymentMethodName == null) return;
    final paymentMethods = await checkoutServices
        .getPaymentMethods((await authServices.currentUser())!.uid);
    paymentMethods.forEach((e) async {
      if (e.name == paymentMethodName) {
        e = e.copyWith(isFav: true);
        await firestoreService.setData(
            path: ApiPaths.paymentMethod(
                (await authServices.currentUser())!.uid, e.id),
            data: e.toMap());
      } else {
        e = e.copyWith(isFav: false);
        await firestoreService.setData(
            path: ApiPaths.paymentMethod(
                (await authServices.currentUser())!.uid, e.id),
            data: e.toMap());
      }
    });
  }
}
