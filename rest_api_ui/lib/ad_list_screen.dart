import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:rest_api_ui/post_new_ad_screen.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_ui/update_ad_screen.dart';

import 'advertisement.dart';

enum PopupMenuType { edit, delete }


class AdListScreen extends StatefulWidget {
  const AdListScreen({super.key});

  @override
  State<AdListScreen> createState() => _AdListScreenState();
}

class _AdListScreenState extends State<AdListScreen> {
  List<Advertisement> adList = [];
  bool _isInProgress = true;

  @override
  void initState() {
    super.initState();

    getAdvertisementList();
  }

  Future<void> getAdvertisementList() async {
    _isInProgress = true;
    setState(() {});

    // await Future.delayed(Duration(milliseconds: 2000), () {});
    //Step 1 - Create URI
    Uri uri = Uri.parse("http://10.0.2.2:3300/advertisements/");

    //Step 2 - Make API Call - GET
    final response = await http.get(uri);

    //Step 3 - Process or Show Response
    print(response);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      adList.clear();
      //decode
      var decodedResponse = jsonDecode(response.body);
      var list = decodedResponse['data'];

      for (var item in list) {
        Advertisement advertisement = Advertisement.fromJson(item);
        adList.add(advertisement);
      }
    }
    _isInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advertisement List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getAdvertisementList();
        },
        child: Visibility(
          visible: _isInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: adList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '${adList[index].thumbnail}',
                  ),
                ),
                title: Text('${adList[index].title}'),
                subtitle: Wrap(
                  spacing: 16,
                  children: [
                    Text('${adList[index].price}'),
                    Text('${adList[index].category}'),
                    Text('Featured: ${adList[index].featured}'),
                  ],
                ),
                trailing: PopupMenuButton<PopupMenuType>(
                  onSelected: (type) {
                    onPopMenuItemSelected(type, adList[index]);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: PopupMenuType.edit,
                      child: Row(
                        children: [
                          Icon(IconlyLight.edit),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Edit')
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: PopupMenuType.delete,
                      child: Row(
                        children: [
                          Icon(IconlyLight.delete),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Delete')
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
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
        icon: const Icon(IconlyLight.plus),
        label: const Text('Post Ad'),
      ),
    );
  }

  Future<void> onPopMenuItemSelected(
      PopupMenuType type, Advertisement advertisement) async {
    switch (type) {
      case PopupMenuType.edit:
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateNewAdScreen(
              advertisement: advertisement,
            ),
          ),
        );

        if (result != null && result == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Advertisement Updated!'),
          ));

          getAdvertisementList();
        }

        break;
      case PopupMenuType.delete:
        _showDeleteDialog(advertisement.id!);
        break;
    }
  }

  void _showDeleteDialog(int adId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Advertisement'),
            content: const Text(
                'Are you sure that you want to delete this advertisement'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _deleteAdvertisement(adId);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Yes, Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _deleteAdvertisement(int adId) async {
    _isInProgress = true;
    setState(() {});

    Uri uri = Uri.parse("http://10.0.2.2:3300/advertisements/$adId");

    final response = await http.delete(uri, headers: {
      'Content-type': 'application/json',
    });

    if (response.statusCode == 200) {
      //deletion from our server is done
      adList.removeWhere((ad) => ad.id == adId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Advertisement deletion failed! Try Again.'),
        ),
      );
    }

    _isInProgress = false;
    setState(() {});
  }
}
