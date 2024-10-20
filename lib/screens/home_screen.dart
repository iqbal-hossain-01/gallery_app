import 'package:flutter/material.dart';
import 'package:gallery_app/models/photo_model.dart';
import 'package:gallery_app/providers/auth_provider.dart';
import 'package:gallery_app/providers/gallery_provider.dart';
import 'package:gallery_app/screens/login_screen.dart';
import 'package:gallery_app/services/firebase_service.dart';
import 'package:gallery_app/widgets/photo_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  final ImagePicker _picker = ImagePicker();
  final FirebaseService _service = FirebaseService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final galleryProvider = Provider.of<GalleryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<FirebaseAuthProvider>().logout()
              .then((_) => Navigator.pushReplacementNamed(context, LoginScreen.routeName));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
        future: galleryProvider.fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('No Data Fetch'),
            );
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemCount: galleryProvider.photos.length,
            itemBuilder: (context, index) {
              return PhotoItem(photo: galleryProvider.photos[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pickedFile = await _picker.pickImage(
              source: ImageSource.gallery);
          if (pickedFile != null) {
            final downloadUrl = await _service.uploadImage(pickedFile.path);

            final newPhoto = PhotoModel(
              id: DateTime.now().toString(),
              url: downloadUrl,
              title: 'My Photo',
            );
            await galleryProvider.addPhoto(newPhoto);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
