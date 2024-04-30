import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:rest_api_crud/edit_ad_screen.dart';
import 'package:rest_api_crud/post_new_ad_screen.dart';

enum PopupMenuType { edit, delete }

class AdListScreen extends StatefulWidget {
  const AdListScreen({super.key});

  @override
  State<AdListScreen> createState() => _AdListScreenState();
}

class _AdListScreenState extends State<AdListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advertisement list'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                  'https://images.unsplash.com/photo-1489824904134-891ab64532f1'),
            ),
            title: const Text('Ad Title'),
            subtitle: const Wrap(
              spacing: 16,
              children: [
                Text('Asking price'),
                Text('Ad Category'),
                Text('Featured or Not'),
              ],
            ),
            trailing: PopupMenuButton<PopupMenuType>(
              onSelected: onTapPopUpMenuButton,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: PopupMenuType.edit,
                  child: Row(
                    children: [
                      Icon(IconlyLight.edit),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: PopupMenuType.delete,
                  child: Row(
                    children: [
                      Icon(IconlyBroken.delete),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostNewAdScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Post Ad'),
      ),
    );
  }

  void onTapPopUpMenuButton(PopupMenuType type) {
    switch (type) {
      case PopupMenuType.edit:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditAdScreen(),
          ),
        );
        break;
      case PopupMenuType.delete:
        _showDeleteDialog();
        break;
    }
  }

  void _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Ad'),
            content: const Text(
                'Are you sure that you want to delete this advertisement'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Yes, Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }
}
