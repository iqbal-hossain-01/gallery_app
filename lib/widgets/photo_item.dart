import 'package:flutter/material.dart';
import 'package:gallery_app/models/photo_model.dart';
import 'package:photo_view/photo_view.dart';

class PhotoItem extends StatelessWidget {
  final PhotoModel photo;

  const PhotoItem({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoView(
              imageProvider: NetworkImage(photo.url),
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: Image.network(
          photo.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
