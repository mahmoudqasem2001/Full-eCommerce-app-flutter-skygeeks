part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);
}

final class CheckoutLoaded extends CheckoutState {
  final List<CartOrdersModel> cartItems;
  final AddressModel preferredLocation;
  final PaymentMethodModel preferredPaymentMethod;
  final List<PaymentMethodModel> paymentMethods;

  final double totalAmount;
  final List<AddressModel> addresses;
  final AddressModel address;

  CheckoutLoaded({
    required this.cartItems,
    required this.preferredLocation,
    required this.preferredPaymentMethod,
    required this.totalAmount,
    required this.addresses,
    required this.address,
    required this.paymentMethods,
  });
}
