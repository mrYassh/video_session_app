import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/call_controller.dart';
import '../widgets/self_camera_preview.dart';

class VideoCallScreen extends StatelessWidget {
  VideoCallScreen({super.key});

  final String sessionId = Get.arguments;
  final CallController controller = Get.put(CallController());

  final RxBool micOn = true.obs;
  final RxBool cameraOn = true.obs;

  @override
  Widget build(BuildContext context) {
    controller.startTimer();

    return Scaffold(
      backgroundColor: const Color(0xFF101622),
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            Expanded(child: _videoArea()),
            _controls(),
          ],
        ),
      ),
    );
  }

  // ─────────── HEADER ───────────
  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.keyboard_arrow_down,
              color: Colors.white),
          Text(
            "Live Session",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Icon(Icons.more_vert, color: Colors.white),
        ],
      ),
    );
  }

  // ─────────── VIDEO AREA ───────────
  Widget _videoArea() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Icon(Icons.person,
                size: 100, color: Colors.white24),
          ),
        ),

        // Self Preview
        Positioned(
          bottom: 32,
          right: 32,
          child: Obx(() =>
          cameraOn.value ? const SelfCameraPreview() : const SizedBox()),
        ),

        // Timer
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: Obx(() => Center(
            child: Text(
              controller.formattedTime,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          )),
        ),
      ],
    );
  }

  // ─────────── CONTROLS ───────────
  Widget _controls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _toggleButton(
            iconOn: Icons.mic,
            iconOff: Icons.mic_off,
            state: micOn,
          ),
          _endCallButton(),
          _toggleButton(
            iconOn: Icons.videocam,
            iconOff: Icons.videocam_off,
            state: cameraOn,
          ),
        ],
      ),
    );
  }

  Widget _toggleButton({
    required IconData iconOn,
    required IconData iconOff,
    required RxBool state,
  }) {
    return Obx(() => GestureDetector(
      onTap: () => state.toggle(),
      child: CircleAvatar(
        radius: 28,
        backgroundColor:
        state.value ? Colors.white : Colors.grey,
        child: Icon(
          state.value ? iconOn : iconOff,
          color: Colors.black,
        ),
      ),
    ));
  }

  Widget _endCallButton() {
    return GestureDetector(
      onTap: () async {
        await controller.endCall(sessionId);
        Get.back();
      },
      child: const CircleAvatar(
        radius: 36,
        backgroundColor: Colors.red,
        child: Icon(Icons.call_end,
            color: Colors.white, size: 32),
      ),
    );
  }
}
