class Book {
  final String id, title, author, language, publisher;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.language,
    required this.publisher,
  });

  factory Book.fromJson(String id, Map<String, dynamic> json) {
    return Book(
      id: id,
      title: json['title'],
      author: json['author'],
      language: json['language'],
      publisher: json['publisher'],
    );
  }
}
