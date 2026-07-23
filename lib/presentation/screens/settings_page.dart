import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:velora/core/utils/app_theme_cubit.dart';
import 'package:velora/core/utils/app_theme_state.dart';
import 'package:velora/app/rounting/routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontFamily: "DMSans",
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 121, 113, 72),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

           
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: const Color.fromARGB(255, 121, 113, 72).withOpacity(0.1),
                    child: const Text(
                      "H", 
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 121, 113, 72),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DMSans",
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "hello@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontFamily: "DMSans",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),

            
            const Text(
              "Preferences",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "DMSans",
                color: Color.fromARGB(255, 121, 113, 72),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: BlocBuilder<AppThemeCubit, AppThemeState>(
                builder: (context, state) {
                  return SwitchListTile(
                    activeColor: const Color.fromARGB(255, 121, 113, 72),
                    title: const Text(
                      "Dark Mode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "DMSans",
                      ),
                    ),
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 121, 113, 72).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.dark_mode_outlined,
                        color: Color.fromARGB(255, 121, 113, 72),
                        size: 20,
                      ),
                    ),
                    value: state.isDark,
                    onChanged: (bool value) {
                     
                      context.read<AppThemeCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 25),

         
            const Text(
              "Account & Support",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "DMSans",
                color: Color.fromARGB(255, 121, 113, 72),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  _buildSettingsTile(
                    icon: Icons.shopping_bag_outlined,
                    title: "My Orders",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 50),
                  _buildSettingsTile(
                    icon: Icons.location_on_outlined,
                    title: "Shipping Address",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 50),
                  _buildSettingsTile(
                    icon: Icons.help_outline_outlined,
                    title: "Help & Support",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

           
            Center(
              child: TextButton.icon(
                onPressed: () {
                 
                  context.pushReplacementNamed(Routes.login);
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "DMSans",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

 
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 121, 113, 72).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color.fromARGB(255, 121, 113, 72),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "DMSans",
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}
