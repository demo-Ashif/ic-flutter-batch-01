import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostNewAdScreen extends StatefulWidget {
  const PostNewAdScreen({super.key});

  @override
  State<PostNewAdScreen> createState() => _PostNewAdScreenState();
}

class _PostNewAdScreenState extends State<PostNewAdScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _createAdInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post New Advertisement'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      hintText: 'Ad Title', labelText: 'Ad Title'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your ad title';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                      hintText: 'Ad Category', labelText: 'Ad Category'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your ad category';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                      hintText: 'Asking price', labelText: 'Asking price'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your asking price';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                      hintText: 'Ad Image', labelText: 'Ad Image'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your ad image';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _createAdInProgress ==false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            postNewAdvertisement();
                          }
                        },
                        child: const Text('Add')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postNewAdvertisement() async {
    _createAdInProgress = true;
    setState(() {});

    Uri uri = Uri.parse("http://10.0.2.2:3300/advertisements/");

    Map<String, dynamic> params = {
      "title": _titleController.text.trim(),
      "thumbnail":
          "https://images.unsplash.com/photo-1569770218135-bea267ed7e84",
      "price": _priceController.text.trim(),
      "featured": false,
      "category": _categoryController.text.trim()
    };

    final response = await http.post(uri, body: jsonEncode(params), headers: {
      'Content-type': 'application/json',
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print("all good");
      _titleController.clear();
      _categoryController.clear();
      _priceController.clear();
      _imageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Advertisement Created!'),
      ));
    }

    _createAdInProgress = false;
    setState(() {});
  }
}
