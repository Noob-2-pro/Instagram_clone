import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future signupUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List? file,
  }) async {
    String? downloadUrl;

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(cred.user);

      if (file != null) {
        downloadUrl = await StorageMethods().uploadImageToStorage('profilePics', false, file);
      }

      await _firestore.collection('users').doc(cred.user!.uid).set({
        'userName': username,
        'email': email,
        'bio': bio,
        'uid': cred.user!.uid,
        'followers': [],
        'following': [],
        'imageUrl': downloadUrl
      });

      return true;
    } on FirebaseAuthException catch (e) {
      return Future.error(Exception(e.message));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future loginUser({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("login done");
      return true;
    } on FirebaseAuthException catch (e) {
      return Future.error(Exception(e.message));
    } catch (e) {
      return Future.error(e);
    }
  }
}
