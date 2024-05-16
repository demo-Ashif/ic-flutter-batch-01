import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_ui/advertisement.dart';

class UpdateNewAdScreen extends StatefulWidget {
  final Advertisement advertisement;

  const UpdateNewAdScreen({
    required this.advertisement,
    super.key,
  });

  @override
  State<UpdateNewAdScreen> createState() => _UpdateNewAdScreenState();
}

class _UpdateNewAdScreenState extends State<UpdateNewAdScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _updateAdInProgress = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.advertisement.title ?? '';
    _categoryController.text = widget.advertisement.category ?? '';
    _priceController.text = widget.advertisement.price ?? '';
    _imageController.text = widget.advertisement.thumbnail ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Advertisement'),
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
                    visible: _updateAdInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            updateNewAdvertisement();
                          }
                        },
                        child: const Text('Update')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateNewAdvertisement() async {
    _updateAdInProgress = true;
    setState(() {});

    Uri uri = Uri.parse(
        "http://10.0.2.2:3300/advertisements/${widget.advertisement.id}");

    Advertisement advertisement = Advertisement(
        title: _titleController.text.trim(),
        thumbnail: _imageController.text.trim(),
        price: _priceController.text.trim(),
        category: _categoryController.text.trim(),
        featured: true);

    final response = await http.put(uri,
        body: jsonEncode(
          advertisement.toJson(),
        ),
        headers: {
          'Content-type': 'application/json',
        });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print("all good");

      Navigator.pop(context, true);
    }

    _updateAdInProgress = false;
    setState(() {});
  }
}
