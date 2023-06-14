import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FormProvider with ChangeNotifier {
  bool _savingData = false;
  bool get loading => _savingData;

  setSaving(bool value) {
    _savingData = value;
    notifyListeners();
  }

  Future<String> saveDataToFirestore(
      String collectionName, Map<String, dynamic> data) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;
      final DocumentReference docRef = await firestore
          .collection('users')
          .doc(user!.uid)
          .collection(collectionName)
          .add(data);
      final String documentId = docRef.id;
      print(documentId);
      return documentId;
    } catch (e) {
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to save data to Firestore: $e',
      );
    }
  }

  Future<void> updateDocIdToFirebase(String collectionName, String documentId,
      Map<String, dynamic> newData) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;
      final DocumentReference docRef = await firestore
          .collection('users')
          .doc(user!.uid)
          .collection(collectionName)
          .doc(documentId);
      await docRef.update(newData);
    } catch (e) {
      throw FirebaseException(
        plugin: 'Firestore',
        message: 'Failed to update document in Firestore: $e',
      );
    }
  }
}
