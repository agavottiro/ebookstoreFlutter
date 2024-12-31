import 'package:dio/dio.dart';
import 'package:ebook_store_ag/model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'e_book_store_event.dart';
part 'e_book_store_state.dart';

const allBooksUrl =
    "https://beca-flutter-ag-default-rtdb.firebaseio.com/ebookStore/allBooks";
const cartUrl =
    "https://beca-flutter-ag-default-rtdb.firebaseio.com/ebookStore/cart";
const purchasedUrl =
    "https://beca-flutter-ag-default-rtdb.firebaseio.com/ebookStore/purchasedBooks";
const favoritesUrl =
    "https://beca-flutter-ag-default-rtdb.firebaseio.com/ebookStore/favoriteBooks";

class EBookStoreBloc extends Bloc<EBookStoreEvent, EBookStoreState> {
  var uuid = Uuid();
  var dio = Dio();

  EBookStoreBloc() : super(EBookStoreState.initial()) {
    on<LoadAllBooksEvent>(_onLoadAllBooksEvent);
    on<LoadPurchasedBooksEvent>(_onLoadPurchasedBooksEvent);
    on<AddToCardEvent>(_onAddToCardEvent);
    on<UpdateCartQuantityEvent>(_onUpdateCartQuantityEvent);
    on<BookmarkEvent>(_onBookmarkEvent);
    on<CurrentlyReadingEvent>(_onCurrentlyReadingEvent);
    on<RemoveBookEvent>(_onRemoveBookEvent);
    on<RemoveBookmarkedBookEvent>(_onRemoveBookmarkedBookEvent);
    on<RemoveCartItemEvent>(_onRemoveCartItemEvent);
    on<LoadCartItemsEvent>(_onLoadCartItemsEvent);
    on<CreateNewBookEvent>(_onCreateNewBookEvent);
    on<EditBookEvent>(_onEditBookEvent);
  }

  void _onLoadAllBooksEvent(
      LoadAllBooksEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(exploreScreenState: ExploreScreenState.loading));

    final response = await dio.get("$allBooksUrl.json");
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state
          .copyWith(exploreScreenState: ExploreScreenState.none, allBooks: []));
      return;
    }

    final books = data.entries.map((b) {
      final book = b.value;
      return BookModel(
          id: book["id"],
          title: book["title"],
          author: book["author"],
          price: double.parse(book["price"].toString()),
          imageUrl: book["imageUrl"]);
    }).toList();

    emit(state.copyWith(
        exploreScreenState: ExploreScreenState.success, allBooks: books));
  }

  void _onLoadPurchasedBooksEvent(
      LoadPurchasedBooksEvent event, Emitter<EBookStoreState> emit) {}

  void _onAddToCardEvent(
      AddToCardEvent event, Emitter<EBookStoreState> emit) async {
    final book = event.book;

    final cartItem = {
      "id": book.id,
      "title": book.title,
      "author": book.author,
      "price": book.price,
      "quantity": 1,
    };

    final itemExistsIndex = state.cart.indexWhere((b) => b.id == book.id);

    if (itemExistsIndex >= 0) {
      final bookItem = state.cart[itemExistsIndex];
      final newQuantity = bookItem.quantity + 1;

      await dio.patch(
        "$cartUrl/${book.id}.json",
        data: {"quantity": newQuantity},
      );

      final updatedCart = [...state.cart, book];
      updatedCart[itemExistsIndex] = bookItem.copyWith(quantity: newQuantity);

      emit(state.copyWith(cart: updatedCart));
    } else {
      await dio.put("$cartUrl/${book.id}.json", data: cartItem);

      final updatedCart = [...state.cart, book];
      emit(state.copyWith(cart: updatedCart));
    }
  }

  void _onUpdateCartQuantityEvent(
      UpdateCartQuantityEvent event, Emitter<EBookStoreState> emit) async {
    final book = event.bookCart;

    final newQuantity = event.newQuantity;

    if (newQuantity < 1 && newQuantity > 5) {
      return;
    }

    final cart = state.cart;

    final index = cart.indexWhere((b) => b.id == event.bookCart.id);

    if (index != -1) {
      final List<BookModel> updatedCart = List<BookModel>.from(cart);

      updatedCart[index] = updatedCart[index].copyWith(quantity: newQuantity);

      await dio.patch(
        "$cartUrl/${book.id}.json",
        data: {
          "quantity": newQuantity,
        },
      );

      emit(state.copyWith(cart: updatedCart));
    }
  }

  void _onBookmarkEvent(BookmarkEvent event, Emitter<EBookStoreState> emit) {}

  void _onCurrentlyReadingEvent(
      CurrentlyReadingEvent event, Emitter<EBookStoreState> emit) {}

  void _onRemoveBookEvent(
      RemoveBookEvent event, Emitter<EBookStoreState> emit) async {
    final BookModel book = event.book;

    await dio.delete("$allBooksUrl/${book.id}.json");

    final updatedBooks =
        state.allBooks.where((b) => b.id != event.book.id).toList();

    emit(state.copyWith(allBooks: updatedBooks));
  }

  void _onRemoveBookmarkedBookEvent(
      RemoveBookmarkedBookEvent event, Emitter<EBookStoreState> emit) {}

  void _onRemoveCartItemEvent(
      RemoveCartItemEvent event, Emitter<EBookStoreState> emit) {}

  void _onLoadCartItemsEvent(
      LoadCartItemsEvent event, Emitter<EBookStoreState> emit) {}

  void _onCreateNewBookEvent(
      CreateNewBookEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(adminScreenState: AdminScreenState.bookAdded));

    final String bookUID = uuid.v1();

    final data = {
      "id": bookUID,
      "title": event.title,
      "author": event.author,
      "imageUrl": event.imageUrl,
      "price": event.price
    };

    await dio.put("$allBooksUrl/$bookUID.json", data: data);

    final newBook = BookModel(
      id: bookUID,
      title: event.title,
      author: event.author,
      price: double.parse(event.price.toString()),
      imageUrl: event.imageUrl,
    );

    final updatedBooks = [...state.allBooks, newBook];
    emit(state.copyWith(
        allBooks: updatedBooks, adminScreenState: AdminScreenState.bookAdded));
  }

  void _onEditBookEvent(
      EditBookEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(adminScreenState: AdminScreenState.bookUpdated));

    final data = {
      "id": event.id,
      "title": event.title,
      "author": event.author,
      "imageUrl": event.imageUrl,
      "price": event.price
    };

    await dio.patch("$allBooksUrl/${event.id}.json", data: data);

    final updatedList = state.allBooks.map((book) {
      if (book.id == event.id) {
        return BookModel(
          id: book.id,
          title: event.title,
          author: event.author,
          price: double.parse(event.price.toString()),
          imageUrl: event.imageUrl,
        );
      }
      return book;
    }).toList();

    emit(state.copyWith(
      allBooks: updatedList,
      adminScreenState: AdminScreenState.bookUpdated,
    ));
  }
}
