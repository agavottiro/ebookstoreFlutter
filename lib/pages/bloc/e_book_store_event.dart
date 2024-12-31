part of 'e_book_store_bloc.dart';

sealed class EBookStoreEvent extends Equatable {
  const EBookStoreEvent();

  @override
  List<Object> get props => [];
}

class LoadAllBooksEvent extends EBookStoreEvent {}

class LoadPurchasedBooksEvent extends EBookStoreEvent {}

class AddToCardEvent extends EBookStoreEvent {
  final BookModel book;

  const AddToCardEvent({required this.book});
}

class UpdateCartQuantityEvent extends EBookStoreEvent {
  final BookModel bookCart;
  final int newQuantity;

  const UpdateCartQuantityEvent(
      {required this.bookCart, required this.newQuantity});
}

class BookmarkEvent extends EBookStoreEvent {
  final BookModel book;

  const BookmarkEvent({required this.book});
}

class CurrentlyReadingEvent extends EBookStoreEvent {
  final BookModel book;

  const CurrentlyReadingEvent({required this.book});
}

class RemoveBookEvent extends EBookStoreEvent {
  final BookModel book;

  const RemoveBookEvent({required this.book});
}

class RemoveBookmarkedBookEvent extends EBookStoreEvent {
  final BookModel book;

  const RemoveBookmarkedBookEvent({required this.book});
}

class RemoveCartItemEvent extends EBookStoreEvent {
  final BookModel book;

  const RemoveCartItemEvent({required this.book});
}

class LoadCartItemsEvent extends EBookStoreEvent {}

class CreateNewBookEvent extends EBookStoreEvent {
  final String title;
  final String author;
  final double price;
  final String imageUrl;

  const CreateNewBookEvent({
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
  });
}

class EditBookEvent extends EBookStoreEvent {
  final String id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;

  const EditBookEvent({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
  });
}
