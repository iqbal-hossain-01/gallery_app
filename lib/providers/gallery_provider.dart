import 'package:flutter/foundation.dart';
import 'package:gallery_app/models/photo_model.dart';
import 'package:gallery_app/services/firebase_service.dart';

class GalleryProvider with ChangeNotifier{
  List<PhotoModel> _photos = [];
  final FirebaseService _firebaseService = FirebaseService();

  List<PhotoModel> get photos => _photos;

  Future<void> fetchPhotos() async {
    _photos = await _firebaseService.fetchPhotos();
    notifyListeners();
  }

  Future<void> addPhoto(PhotoModel photo) async {
    await _firebaseService.uploadPhoto(photo);
    _photos.add(photo);
    notifyListeners();
  }
}