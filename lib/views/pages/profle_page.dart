import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../utils/route/app_routes.dart';
import '../../view_models/auth_cubit/auth_cubit.dart';
import '../widgets/main_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final phoneController = TextEditingController();
    final name = TextEditingController();
    final email = TextEditingController();
    Widget _buildPhoneNumberFormField(
        BuildContext context, String label, String value) {
      return IntlPhoneField(
        initialValue: value,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.phone),
          labelText: label,
          hintText: value,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            gapPadding: 5,
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            gapPadding: 5,
            borderSide: const BorderSide(color: Colors.black),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        initialCountryCode: 'PS',
        keyboardType: TextInputType.phone,
        controller: phoneController,
        validator: (value) {
          if (value!.toString().isEmpty) {
            return "PhoneNumber must not be empty";
          }
          return null;
        },
      );
    }

    Widget _buildNameField(BuildContext context, String label, String value) {
      return TextFormField(
        enabled: false,
        keyboardType: TextInputType.name,
        controller: name,
        validator: (value) {
          if (value!.isEmpty) {
            return "Your name must not be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: value,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Colors.black),
            gapPadding: 5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            gapPadding: 5,
            borderSide: const BorderSide(color: Colors.black),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.person),
        ),
      );
    }

    TextFormField _buildEmailField(
        BuildContext context, String label, String value) {
      return TextFormField(
        enabled: false,
        keyboardType: TextInputType.emailAddress,
        controller: email,
        validator: (value) {
          if (value!.isEmpty) {
            return "Email must not be empty";
          } else if (!value.contains('@')) {
            return "Please enter a valid email";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          hintText: value,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: const BorderSide(color: Colors.black),
            gapPadding: 5,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            gapPadding: 5,
            borderSide: const BorderSide(color: Colors.black),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: const Icon(Icons.email),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: authCubit,
          listenWhen: (previous, current) =>
              current is AuthFailure || current is AuthInitial,
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
            } else if (state is AuthInitial) {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed(AppRoutes.homeLogin);
            }
          },
          buildWhen: (previous, current) =>
              current is AuthLoading || current is AuthFailure,
          builder: (context, state) {
            if (state is AuthLoading) {
              return const MainButton(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is AuthSuccess) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildNameField(
                        context,
                        "Username:",
                        user!.displayName != null &&
                                user.displayName!.isNotEmpty
                            ? user.displayName!
                            : "No Name Added"),
                    const SizedBox(height: 20),
                    _buildEmailField(context, "Email:",
                        user.email != null ? user.email! : "No Email Exist"),
                    const SizedBox(height: 40),
                    _buildPhoneNumberFormField(context, "Phone Number :",
                        user.phoneNumber != null ? user.phoneNumber! : ""),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        authCubit.updatePhoneNumber(phoneController.text);
                      },
                      child: const Text('Save'),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            }
            return MainButton(
              title: 'Logout',
              onPressed: () async {
                await authCubit.signOut();
              },
            );
          },
        ),
      ),
    );
  }
}
