
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../../screens/auth/methods/user_storage.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String caption, String uid, String username, String profImage, Uint8List image) async {
    String res = "An error occurred";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage(true, 'posts', image);
      String postId = const Uuid().v1();

      await _firestore.collection('posts').doc(postId).set({
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'postId': postId,
        'datePublished': DateTime.now(),
        'postUrl': photoUrl,
        'likes': [],
      });

      res = "Ok";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
