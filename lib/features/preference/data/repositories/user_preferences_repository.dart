import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_preference.dart';

class UserPreferencesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Upsert preferences (one-to-one by userId)
  Future<void> saveUserPreferences(UserPreferences prefs) async {
    await _firestore
        .collection('user_preferences')
        .doc(prefs.userId)
        .set(prefs.toJson(), SetOptions(merge: true));
  }

  /// Fetch existing preferences
  Future<UserPreferences?> getUserPreferences(String userId) async {
    final doc = await _firestore.collection('user_preferences').doc(userId).get();
    if (!doc.exists) return null;
    return UserPreferences.fromJson(doc.data()!);
  }

  /// Stream for real-time updates
  Stream<UserPreferences?> watchUserPreferences(String userId) {
    return _firestore
        .collection('user_preferences')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.exists ? UserPreferences.fromJson(doc.data()!) : null);
  }
}