import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(

        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF135BEC),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 36),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Yash Dipke",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Mobile App Developer",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.video_call),
            title: const Text("My Sessions"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text("Schedule Session"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout",
                style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
