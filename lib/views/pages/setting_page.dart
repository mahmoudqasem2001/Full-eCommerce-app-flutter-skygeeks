import 'package:ecommerce_app/views/pages/profle_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/route/app_routes.dart';
import '../../view_models/auth_cubit/auth_cubit.dart';
import '../widgets/settings_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTql7QO1cKJ2vGPissyg8P5dvN0F0fmajfgtEoaIywuRg&s"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTql7QO1cKJ2vGPissyg8P5dvN0F0fmajfgtEoaIywuRg&s"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "General",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SettingsButton(
                title: "Edit Profile",
                icon: Icons.person_outlined,
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ProfilePage(),
                    ),
                  );
                },
              ),
              const SettingsButton(
                title: "Change Password",
                icon: Icons.lock,
              ),
              const SettingsButton(
                title: "Notifications",
                icon: Icons.shopping_cart_outlined,
              ),
              const SettingsButton(
                title: "Language",
                icon: Icons.language,
              ),
              const SettingsButton(
                title: "Help and Support",
                icon: Icons.help,
              ),
              SettingsButton(
                title: "Log Out",
                icon: Icons.logout_outlined,
                onTap: ()  {
                  authCubit.signOut();
                  Navigator.pushReplacementNamed(context, AppRoutes.homeLogin);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
