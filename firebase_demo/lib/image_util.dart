import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUtil {
  final ImagePicker _picker = ImagePicker();

  Future<Map<String, String>?> pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String fileName = 'profile_${DateTime.now().microsecondsSinceEpoch}.jpg';

      try {
        //upload image ot Firebase Storage
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child(fileName)
            .putFile(file);

        //Get image download url
        String downloadUrl = await snapshot.ref.getDownloadURL();

        //Save image URL to FireStore
        await FirebaseFirestore.instance
            .collection('profile')
            .doc('user_id')
            .set({'imageUrl': downloadUrl, 'imageName': fileName});

        return {'imageUrl': downloadUrl, 'imageName': fileName};
      } catch (e) {
        print(e);
      }
    }

    return null;
  }
}

/*
* Assignment
* 1. Show a Button (Upload Image)
* 2. Pick Image and Upload into Firebase storage
* 3. Show all uploaded image in gridview like gallery*/
