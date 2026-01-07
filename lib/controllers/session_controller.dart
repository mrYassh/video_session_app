import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SessionController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final sessions = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    fetchUpcomingSessions();
    super.onInit();
  }

  void fetchUpcomingSessions() {
    _firestore
        .collection('sessions')
        .where('status', isEqualTo: 'upcoming')
        .snapshots()
        .listen((snapshot) {
      sessions.value =
          snapshot.docs.map((e) => {...e.data(), 'id': e.id}).toList();
      isLoading.value = false;
    });
  }

  Future<void> markSessionOngoing(String sessionId) async {
    await _firestore
        .collection('sessions')
        .doc(sessionId)
        .update({'status': 'ongoing'});
  }
}
