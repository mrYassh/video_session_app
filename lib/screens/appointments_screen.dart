import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_session_app/widgets/app_drawer.dart';
import '../controllers/session_controller.dart';
import '../utils/permissions.dart';

class AppointmentsScreen extends StatelessWidget {
  AppointmentsScreen({super.key});

  final SessionController controller = Get.put(SessionController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F8),
        drawer: AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0.9),
          title: const Text(
            "Upcoming Sessions",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
      
          actions: [
            IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          ],
        ),
      
        // 🔥 DYNAMIC BODY
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
      
          if (controller.sessions.isEmpty) {
            return Center(child: _emptyState());
          }
      
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: controller.sessions.length,
            itemBuilder: (_, index) {
              final session = controller.sessions[index];
      
              return _sessionCard(
                title: session['title'],
                time: session['scheduledAt'] ?? "",
                imageUrl:
                "https://images.unsplash.com/photo-1521737604893-d14cc237f11d",
                primaryButton: true,
                buttonText: "Join Session",
                buttonIcon: Icons.videocam,
                onJoin: () async {
                  final granted = await requestCameraMicPermission();
                  if (!granted) {
                    Get.snackbar(
                      "Permission Required",
                      "Camera & Microphone permissions are needed",
                    );
                    return;
                  }
      
                  await controller.markSessionOngoing(session['id']);
                  Get.toNamed('/call', arguments: session['id']);
                },
              );
            },
          );
        }),
      
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF135BEC),
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  // ───────────────── MODIFIED CARD ─────────────────
  Widget _sessionCard({
    String? tag,
    Color? tagColor,
    required String title,
    required String time,
    required String imageUrl,
    String buttonText = "",
    IconData? buttonIcon,
    bool primaryButton = false,
    VoidCallback? onJoin,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.schedule,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(time,
                              style:
                              const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onJoin,
                icon: Icon(buttonIcon),
                label: Text(buttonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF135BEC),
                  padding:
                  const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.event_busy, size: 64, color: Colors.blue),
        SizedBox(height: 16),
        Text("No upcoming sessions",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(
          "You're all caught up! Check back later.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
