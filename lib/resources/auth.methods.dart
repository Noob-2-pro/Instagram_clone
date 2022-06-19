import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthMethods {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final _firestoreInstance = FirebaseStorage.instance;

  // signupUser({
  //   required String email,
  //   required String username,
  //   required String password,
  //   required String bio,
  //   required Uint8List file,
  // }) async {
  //   UserCredential user = await _authInstance.createUserWithEmailAndPassword(email: email, password: password);
  //   _firestoreInstance.
  // }
}
