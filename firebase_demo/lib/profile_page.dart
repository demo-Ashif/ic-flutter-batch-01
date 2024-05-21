import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/image_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _imageUrl;
  String _imageName = "";

  final ImageUtil _imageUtil = ImageUtil();

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    var profileSnapShot = await FirebaseFirestore.instance
        .collection('profile')
        .doc('user_id')
        .get();

    if (profileSnapShot.exists) {
      setState(() {
        _imageUrl = profileSnapShot['imageUrl'];
        _imageName = profileSnapShot['imageName'];
      });
    }
  }

  //image pick method
  Future<void> _pickAndUploadImage() async {
    // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //
    // if (pickedFile != null) {
    //   File file = File(pickedFile.path);
    //   String fileName = 'profile_${DateTime.now().microsecondsSinceEpoch}.jpg';
    //
    //   try {
    //     //upload image ot Firebase Storage
    //     TaskSnapshot snapshot = await FirebaseStorage.instance
    //         .ref()
    //         .child('profile_images')
    //         .child(fileName)
    //         .putFile(file);
    //
    //     //Get image download url
    //     String downloadUrl = await snapshot.ref.getDownloadURL();
    //
    //     //Save image URL to FireStore
    //     await FirebaseFirestore.instance
    //         .collection('profile')
    //         .doc('user_id')
    //         .set({'imageUrl': downloadUrl, 'imageName': fileName});

    var result = await _imageUtil.pickAndUploadImage();

    try {
      if (result != null) {
        //update ui
        setState(() {
          _imageUrl = result['imageUrl'];
          _imageName = result['imageName']!;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  _imageUrl != null ? NetworkImage(_imageUrl!) : null,
              child: _imageUrl == null
                  ? const Icon(
                      Icons.person,
                      size: 50,
                    )
                  : null,
            ),
            SizedBox(height: 10),
            Text('$_imageName'),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _pickAndUploadImage,
                child: Text('Change Profile Picture'))
          ],
        ),
      ),
    );
  }
}
