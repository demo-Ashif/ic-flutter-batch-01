import 'package:flutter/material.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                    hintText: 'Ad Category',
                    labelText: 'Ad Category',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter ad category';
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
                      return 'Enter your product unit price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    hintText: 'Ad Image',
                    labelText: 'Ad Image',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your ad image';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text('Add'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
