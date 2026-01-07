import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CallController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxInt seconds = 0.obs;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    seconds.value = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds.value++;
    });
  }

  String get formattedTime {
    final min = (seconds.value ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds.value % 60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  Future<void> endCall(String sessionId) async {
    _timer?.cancel();

    await _firestore.collection('sessions').doc(sessionId).update({
      'status': 'completed',
      'durationInSeconds': seconds.value,
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
