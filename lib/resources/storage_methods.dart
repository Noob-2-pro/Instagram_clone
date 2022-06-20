import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final _firebaseStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childName, bool isPost, Uint8List image) async {
    Reference ref = _firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    var snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
