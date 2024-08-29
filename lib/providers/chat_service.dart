import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Stream<List<MessageModel>> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> sendMessage(String text) async {
    UserModel? user = await getCurrentUser();
    if (user != null) {
      await _firestore.collection('messages').add({
        'senderId': user.id,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}