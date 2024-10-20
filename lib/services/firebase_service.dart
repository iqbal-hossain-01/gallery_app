import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_app/models/photo_model.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static const String _collectionAdmin = 'Admins';

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _firestore.collection(_collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  Future<void> uploadPhoto(PhotoModel photo) async {
    await _firestore.collection('photos').add({
      'id': photo.id,
      'url': photo.url,
      'title': photo.title,
    });
  }

  Future<List<PhotoModel>> fetchPhotos() async {
    final snapshot = await _firestore.collection('photos').get();
    return snapshot.docs.map((doc) {
      return PhotoModel(
        id: doc['id'],
        url: doc['url'],
        title: doc['title'],
      );
    }).toList();
  }
  
  Future<String> uploadImage(String filePath) async {
    File file = File(filePath);
    
    try {
      String fileName = file.uri.pathSegments.last;
      await _storage.ref('photos/$fileName').putFile(file);
      String downloadUrl = await _storage.ref('photos/$fileName').getDownloadURL();
      return downloadUrl;
    } catch (error) {
      throw error;
    }
  }
}
