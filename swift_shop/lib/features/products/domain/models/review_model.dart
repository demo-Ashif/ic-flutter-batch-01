import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  const ReviewModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
  });

  ReviewModel.empty()
      : id = "Test String",
        userId = "Test String",
        userName = "Test String",
        comment = "Test String",
        rating = 1,
        date = DateTime.now();

  final String id;
  final String userId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;

  // fromJson method to deserialize the object
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      comment: json['comment'] as String,
      rating: (json['rating'] as num).toDouble(), // Ensure rating is double
      date: DateTime.parse(json['date'] as String),
    );
  }

  // copyWith method to create a modified copy of the object
  ReviewModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? comment,
    double? rating,
    DateTime? date,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      date: date ?? this.date,
    );
  }

  @override
  List<dynamic> get props => [
    id,
    userId,
    userName,
    rating,
    date,
  ];
}
