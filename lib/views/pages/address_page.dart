import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/address_model.dart';
import '../../view_models/checkout_cubit/checkout_cubit.dart';
import '../widgets/main_button.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    final size = MediaQuery.of(context).size;
    String chosenAddress = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          bloc: checkoutCubit,
          buildWhen: (previous, current) =>
              current is CheckoutError ||
              current is CheckoutLoaded ||
              current is CheckoutLoading,
          builder: (context, state) {
            if (state is CheckoutError) {
              return Center(child: Text(state.message));
            } else if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is CheckoutLoaded) {
              chosenAddress =
                  state.addresses.isNotEmpty ? state.addresses[0].name : '';

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      "Choose your Preferred Location",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    DropdownMenu(
                      width: size.width * 0.75,
                      dropdownMenuEntries: state.addresses
                          .map<DropdownMenuEntry>(
                            (e) => DropdownMenuEntry(value: e, label: e.name),
                          )
                          .toList(),
                      onSelected: (value) {
                        AddressModel address = value;
                        chosenAddress = address.name;
                      },
                      initialSelection: Text(chosenAddress),
                    ),
                    const Spacer(),
                    MainButton(
                      title: "Confirm Location",
                      onPressed: () async {
                        await checkoutCubit.setAddress(chosenAddress);
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    )
                  ],
                ),
              );
            } else {
              return const Text("Error Page");
            }
          },
        ),
      ),
    );
  }
}
