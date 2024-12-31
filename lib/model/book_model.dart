import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final int quantity;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    double? price,
    String? imageUrl,
    int? quantity,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        price,
        imageUrl,
        quantity,
      ];
}
