import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout(BuildContext context) async {
    final auth = AuthService();
    await auth.signOut(); // 👈 Sign out
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // PROFILE INFO (Dummy)
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/default_profile.png'), // you can add this image
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Your Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Hey there! I'm using Chat App", style: TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),

          const SizedBox(height: 30),

          // SETTINGS LIST (Dummy options)
          const Text("General", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),

          // Notifications (dummy)
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () {}, //dummy
          ),

          // Appearance (controls dark mode)
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("Appearance"),
            trailing: CupertinoSwitch(
              value: themeProvider.isDarkMode,
              onChanged: (value) => themeProvider.toggleTheme(), // 👈 dark mode toggle
            ),
          ),

          // Privacy (dummy)
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Privacy"),
            onTap: () {}, //dummy
          ),

          // Help (dummy)
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Help"),
            onTap: () {}, //dummy
          ),

          const SizedBox(height: 30),

          // LOGOUT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => logout(context), // 👈 logout
          ),
        ],
      ),
    );
  }
}
