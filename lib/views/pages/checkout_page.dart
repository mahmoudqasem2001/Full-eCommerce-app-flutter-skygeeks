import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:ecommerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:ecommerce_app/views/pages/address_page.dart';
import 'package:ecommerce_app/views/widgets/checkout_cart_item_widget.dart';
import 'package:ecommerce_app/views/widgets/checkout_title_widget.dart';
import 'package:ecommerce_app/views/widgets/location_item_widget.dart';
import 'package:ecommerce_app/views/widgets/main_button.dart';
import 'package:ecommerce_app/views/widgets/payment_method_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CheckoutCubit>(context);
    final size = MediaQuery.of(context).size;
    String? paymentMethod;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            current is CheckoutLoaded ||
            current is CheckoutLoading ||
            current is CheckoutError,
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CheckoutError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CheckoutLoaded) {
            final cartItems = state.cartItems;
            final totalAmount = state.totalAmount;
            final preferredLocation = state.preferredLocation;

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckoutTitleWidget(
                        title: 'Address',
                        onEditTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return BlocProvider.value(
                                  value: cubit,
                                  child: const AddressPage(),
                                );
                              },
                            ),
                          ).then(
                            (value) => cubit.getCheckoutPage(),
                          );
                        },
                      ),
                      LocationItemWidget(location: preferredLocation),
                      const SizedBox(height: 24),
                      CheckoutTitleWidget(
                        title: 'Products',
                        numOfItems: cartItems.length,
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartItems[index];
                          return CheckoutCartItemWidget(cartItem: cartItem);
                        },
                      ),
                      const SizedBox(height: 16),
                      const CheckoutTitleWidget(
                        title: 'Payment Methods',
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: AppColors.white,
                              constraints: BoxConstraints(
                                maxHeight: (size.height / 3) * 2,
                                minHeight: size.height / 3,
                                minWidth: size.width,
                              ),
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Payment Method",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 20),
                                      ...state.paymentMethods.map((e) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              paymentMethod = e.name;
                                              Navigator.pop(context);
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                  color: AppColors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              22),
                                                      child: Image.network(
                                                        e.imgUrl,
                                                        height: 120,
                                                        width: 120,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e.name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                        ),
                                                        Text(
                                                          e.cardNumber,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      AppColors
                                                                          .grey),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                );
                              },
                            ).then((value) {
                              cubit.setPaymentMethod(paymentMethod);
                              cubit.getCheckoutPage();
                            });
                          },
                          child: PaymentMethodItemWidget(
                              paymentMethod: state.preferredPaymentMethod)),
                      const SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColors.grey,
                                ),
                          ),
                          Text(
                            '\$ $totalAmount',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      MainButton(
                        title: 'Checkout Now',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Error Page!'),
            );
          }
        },
      ),
    );
  }
}
