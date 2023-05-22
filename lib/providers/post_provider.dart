import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../models/FormModel.dart';

class PostListProvider with ChangeNotifier {
  final int pageSize = 10;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<FormData> _posts = [];
  bool _isLoading = false;
  bool _hasError = false;
  DocumentSnapshot? _lastDocument;
  String _searchQuery = '';

  List<FormData> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  PostListProvider() {
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      Query query = _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('service_history')
          .orderBy('timestamp', descending: true)
          .limit(pageSize);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;
      }

      final newPosts = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return FormData.fromJson(data as Map<String, dynamic>);
      }).toList();

      _posts.addAll(newPosts);
      // _posts.sort((a,b)=> b.timestamp.compareTo(a.timestamp));

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }

  void loadMorePosts() {
    if (_isLoading) {
      return;
    }
    fetchPosts();
  }

  void resetPosts() {
    _lastDocument = null;
    _posts = [];
    fetchPosts();
  }

  void searchPosts(String query) async {
    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('service_history')
          .where('customerName', isGreaterThanOrEqualTo: query)
          .where('customerName', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      _posts = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return FormData.fromJson(data);
      }).toList();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      _isLoading = false;
      _hasError = true;
      notifyListeners();
    }
  }
}
