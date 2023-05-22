
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FormProvider with ChangeNotifier{
  bool _savingData =false;
  bool get loading => _savingData;

  setSaving(bool value){
    _savingData = value;
    notifyListeners();
  }

  Future<void> saveDataToFirestore(String collectionName, Map<String, dynamic> data) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    await firestore.collection('users').doc(user!.uid).collection(collectionName).add(data);
  }

}