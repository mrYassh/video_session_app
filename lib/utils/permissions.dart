import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCameraMicPermission() async {
  final camera = await Permission.camera.request();
  final mic = await Permission.microphone.request();

  if (camera.isGranted && mic.isGranted) {
    return true;
  }

  if (camera.isPermanentlyDenied || mic.isPermanentlyDenied) {
    await openAppSettings();
  }

  return false;
}
