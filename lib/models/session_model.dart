import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String id;
  final String title;
  final String status;
  final int duration;

  SessionModel({
    required this.id,
    required this.title,
    required this.status,
    required this.duration,
  });

  factory SessionModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SessionModel(
      id: doc.id,
      title: data['title'],
      status: data['status'],
      duration: data['durationInSeconds'] ?? 0,
    );
  }
}
