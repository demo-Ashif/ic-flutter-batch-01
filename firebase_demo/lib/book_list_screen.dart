import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final List<Book> bookList = [];

  @override
  void initState() {
    super.initState();

    // _getBooks();
  }

  void _getBooks() async {
    await _firebaseFirestore.collection("books").get().then((snapshot) {
      bookList.clear();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        bookList.add(Book.fromJson(doc.id, doc.data() as Map<String, dynamic>));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: StreamBuilder(
          stream: _firebaseFirestore.collection('books').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            bookList.clear();
            for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
              bookList.add(
                  Book.fromJson(doc.id, doc.data() as Map<String, dynamic>));
            }

            return ListView.separated(
              itemBuilder: (context, index) => ListTile(
                title: Text(bookList[index].title),
                subtitle: Text(bookList[index].author),
                leading: Text(bookList[index].language),
                trailing: Text(bookList[index].publisher),
              ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: bookList.length,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map<String, dynamic> newBook = {
            'title': 'MR 9',
            'author': 'Kazi Anwar',
            'language': 'BN',
            'publisher': 'Seba Pub.'
          };

          //adding new entry in cloud firestore
          // _firebaseFirestore.collection('books').doc('new-book-2').set(newBook);

          //updating entry in cloud firestore
          // _firebaseFirestore.collection('books').doc('new-book-2').update(newBook);

          //deleting entry in cloud firestore
          _firebaseFirestore.collection('books').doc('new-book-2').delete();


        },
        child: Icon(Icons.add),
      ),
    );
  }
}
