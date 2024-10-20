import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoDetailScreen extends StatelessWidget {
  final String imageUrl;

  const PhotoDetailScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo View'),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
