import 'package:ecommerce_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/route/app_routes.dart';
import '../../view_models/auth_cubit/auth_cubit.dart';
import '../widgets/main_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Center(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  _buildProfileInfo(
                      context,
                      "Username:",
                      user!.displayName != null
                          ? user.displayName!
                          : "No Name Exist"),
                  const SizedBox(height: 20),
                  _buildProfileInfo(context, "Email:", user.email != null
                          ? user.email!
                          : "No Email Exist"),
                  const SizedBox(height: 40),
                  _buildLogoutButton(context, authCubit),
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
    );
  }

  Widget _buildProfileInfo(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.all(Radius.circular(7)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthCubit authCubit) {
    return MainButton(
      title: 'Logout',
      onPressed: () async {
        await authCubit.signOut();
        Navigator.of(context).pushReplacementNamed(AppRoutes.homeLogin);
      },
    );
  }
}
