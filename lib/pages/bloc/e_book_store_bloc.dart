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
const currentlyReadingUrl =
    "https://beca-flutter-ag-default-rtdb.firebaseio.com/ebookStore/currentlyReading";

class EBookStoreBloc extends Bloc<EBookStoreEvent, EBookStoreState> {
  var uuid = Uuid();
  var dio = Dio();

  EBookStoreBloc() : super(EBookStoreState.initial()) {
    on<LoadAllBooksEvent>(_onLoadAllBooksEvent);
    on<LoadPurchasedBooksEvent>(_onLoadPurchasedBooksEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<UpdateCartQuantityEvent>(_onUpdateCartQuantityEvent);
    on<BookmarkEvent>(_onBookmarkEvent);
    on<CurrentlyReadingEvent>(_onCurrentlyReadingEvent);
    on<RemoveBookEvent>(_onRemoveBookEvent);
    on<RemoveBookmarkedBookEvent>(_onRemoveBookmarkedBookEvent);
    on<RemoveCartItemEvent>(_onRemoveCartItemEvent);
    on<CheckoutEvent>(_onCheckoutEvent);
    on<LoadCartItemsEvent>(_onLoadCartItemsEvent);
    on<CreateNewBookEvent>(_onCreateNewBookEvent);
    on<EditBookEvent>(_onEditBookEvent);
    on<LoadCurrentlyReadingBookEvent>(_onLoadCurrentlyReadingBookEvent);
  }

  void _onLoadAllBooksEvent(
      LoadAllBooksEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(exploreScreenState: ExploreScreenState.loading));

    final response = await dio.get("$allBooksUrl.json");
    final data = response.data as Map<String, dynamic>?;

    final responseCart = await dio.get("$cartUrl.json");
    final dataCart = responseCart.data as Map<String, dynamic>?;

    final responseCurrentlyReading = await dio.get("$currentlyReadingUrl.json");
    final dataCurrentlyReading =
        responseCurrentlyReading.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(
        exploreScreenState: ExploreScreenState.none,
        allBooks: [],
        currentlyReadingBooks: [],
      ));
      return;
    }

    final books = data.entries.map((b) {
      final book = b.value;
      return BookModel(
        id: book["id"],
        title: book["title"],
        author: book["author"],
        price: double.parse(book["price"].toString()),
        imageUrl: book["imageUrl"],
        isFavorite: book["isFavorite"] ?? false,
      );
    }).toList();

    List<BookModel> cartListItems = [];
    if (dataCart != null) {
      cartListItems = dataCart.entries.map((b) {
        final cartBook = b.value;
        final existingBook = books.firstWhere(
          (book) => book.id == b.key,
          orElse: () => BookModel(
            id: b.key,
            title: cartBook["title"],
            price: double.parse(cartBook["price"].toString()),
            author: cartBook["author"],
            imageUrl: cartBook["imageUrl"],
            quantity: 1,
          ),
        );
        return existingBook.copyWith(quantity: cartBook["quantity"] ?? 1);
      }).toList();
    }

    List<BookModel> currentlyReadingBooks = [];
    BookModel? currentlyReadingBook;
    if (dataCurrentlyReading != null) {
      currentlyReadingBooks = dataCurrentlyReading.entries.map((b) {
        final book = b.value;
        final bookModel = BookModel(
          id: book["id"],
          title: book["title"],
          author: book["author"],
          price: double.parse(book["price"].toString()),
          imageUrl: book["imageUrl"],
          currentlyReading: book["currentlyReading"] ?? false,
        );

        if (bookModel.currentlyReading) {
          currentlyReadingBook = bookModel;
        }

        return bookModel;
      }).toList();
    }

    emit(state.copyWith(
      exploreScreenState: ExploreScreenState.success,
      allBooks: books,
      cart: cartListItems,
      currentlyReadingBooks: currentlyReadingBooks,
      currentlyReadingBook: currentlyReadingBook,
    ));
  }

  void _onLoadPurchasedBooksEvent(
      LoadPurchasedBooksEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(purchasedScreenState: PurchasedScreenState.loading));

    final response = await dio.get("$purchasedUrl.json");
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(
          purchasedScreenState: PurchasedScreenState.none, purshasedBooks: []));
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
      purchasedScreenState: PurchasedScreenState.success,
      purshasedBooks: books,
    ));
  }

  void _onAddToCartEvent(
      AddToCartEvent event, Emitter<EBookStoreState> emit) async {
    final book = event.book;

    final cartItem = {
      "id": book.id,
      "title": book.title,
      "author": book.author,
      "price": book.price,
      "imageUrl": book.imageUrl,
      "quantity": book.quantity,
      "currentlyReading": book.currentlyReading,
      "isFavorite": book.isFavorite,
    };

    final itemExistsIndex = state.cart.indexWhere((b) => b.id == book.id);

    if (itemExistsIndex >= 0) {
      final bookItem = state.cart[itemExistsIndex];
      final newQuantity = bookItem.quantity + book.quantity;

      await dio.patch(
        "$cartUrl/${book.id}.json",
        data: {"quantity": newQuantity},
      );

      final updatedCart = List.of(state.cart);
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

    if (newQuantity < 1 || newQuantity > 5) {
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

  void _onBookmarkEvent(
      BookmarkEvent event, Emitter<EBookStoreState> emit) async {
    final book = event.book;

    final updatedBook = book.copyWith(isFavorite: !book.isFavorite);

    final updatedBooks = state.allBooks.map((b) {
      return b.id == book.id ? updatedBook : b;
    }).toList();

    final updatedBookData = {
      "id": updatedBook.id,
      "title": updatedBook.title,
      "author": updatedBook.author,
      "price": updatedBook.price,
      "imageUrl": updatedBook.imageUrl,
      "isFavorite": updatedBook.isFavorite,
    };

    await dio.patch("$allBooksUrl/${updatedBook.id}.json",
        data: updatedBookData);

    emit(state.copyWith(allBooks: updatedBooks));
  }

  void _onCurrentlyReadingEvent(
    CurrentlyReadingEvent event,
    Emitter<EBookStoreState> emit,
  ) async {
    final updatedCurrentlyReadingBooks =
        state.currentlyReadingBooks.map((book) {
      return book.copyWith(currentlyReading: false);
    }).toList();

    final BookModel newCurrentlyReadingBook =
        event.book.copyWith(currentlyReading: true);

    updatedCurrentlyReadingBooks.add(newCurrentlyReadingBook);

    for (var book in updatedCurrentlyReadingBooks) {
      if (!book.currentlyReading) {
        await dio.put(
          "$currentlyReadingUrl/${book.id}.json",
          data: {
            "id": book.id,
            "title": book.title,
            "author": book.author,
            "price": book.price,
            "imageUrl": book.imageUrl,
            "currentlyReading": false,
            "isFavorite": book.isFavorite,
          },
        );
      }
    }

    await dio.put(
      "$currentlyReadingUrl/${newCurrentlyReadingBook.id}.json",
      data: {
        "id": newCurrentlyReadingBook.id,
        "title": newCurrentlyReadingBook.title,
        "author": newCurrentlyReadingBook.author,
        "price": newCurrentlyReadingBook.price,
        "imageUrl": newCurrentlyReadingBook.imageUrl,
        "currentlyReading": true,
        "isFavorite": newCurrentlyReadingBook.isFavorite,
      },
    );

    emit(state.copyWith(
      currentlyReadingBooks: updatedCurrentlyReadingBooks,
      currentlyReadingBook: newCurrentlyReadingBook,
      currentlyReadingState: CurrentlyReadingState.success,
    ));
  }

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
      RemoveCartItemEvent event, Emitter<EBookStoreState> emit) async {
    final BookModel book = event.book;

    await dio.delete("$cartUrl/${book.id}.json");

    final updatedCart = state.cart.where((b) => b.id != event.book.id).toList();

    emit(state.copyWith(cart: updatedCart));
  }

  void _onLoadCartItemsEvent(
      LoadCartItemsEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(cartScreenState: CartScreenState.loading));

    final response = await dio.get("$cartUrl.json");

    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(cartScreenState: CartScreenState.none, cart: []));
      return;
    }

    final currentCart = state.cart;

    final cartBooks = data.entries.map((b) {
      final book = b.value;

      final existingBook = currentCart.firstWhere(
        (item) => item.id == book["id"],
        orElse: () => BookModel(
          id: book["id"],
          title: book["title"],
          author: book["author"],
          price: book["price"].toDouble(),
          imageUrl: book["imageUrl"],
          quantity: 1,
        ),
      );

      return existingBook.copyWith(
        title: book["title"],
        author: book["author"],
        price: book["price"].toDouble(),
        imageUrl: book["imageUrl"],
      );
    }).toList();

    emit(state.copyWith(
      cartScreenState: CartScreenState.success,
      cart: cartBooks,
    ));
  }

  void _onCreateNewBookEvent(
      CreateNewBookEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(adminScreenState: AdminScreenState.bookAdded));

    final String bookUID = uuid.v1();

    final data = {
      "id": bookUID,
      "title": event.title,
      "author": event.author,
      "imageUrl": event.imageUrl,
      "price": event.price,
      "isFavorite": event.isFavorite,
    };

    await dio.put("$allBooksUrl/$bookUID.json", data: data);

    final newBook = BookModel(
      id: bookUID,
      title: event.title,
      author: event.author,
      price: double.parse(event.price.toString()),
      imageUrl: event.imageUrl,
      isFavorite: event.isFavorite,
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

  void _onCheckoutEvent(
      CheckoutEvent event, Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(cartScreenState: CartScreenState.loading));

    final response = await dio.get("$purchasedUrl.json");
    final data = response.data as Map<String, dynamic>? ?? {};

    final books = event.books
        .where(
          (book) => !data.containsKey(book.id),
        )
        .map(
          (book) => book.copyWith(currentlyReading: false),
        )
        .toList();

    final booksJson = Map.fromEntries(
      books.map(
        (book) => MapEntry(
          book.id,
          {
            "id": book.id,
            "title": book.title,
            "author": book.author,
            "price": book.price,
            "quantity": book.quantity,
            "imageUrl": book.imageUrl,
            "currentlyReading": book.currentlyReading,
            "isFavotite": book.isFavorite,
          },
        ),
      ),
    );

    if (booksJson.isNotEmpty) {
      await dio.patch("$purchasedUrl.json", data: booksJson);
    }

    await dio.delete("$cartUrl.json");

    emit(state.copyWith(
      cart: [],
      cartScreenState: CartScreenState.none,
    ));
  }

  void _onLoadCurrentlyReadingBookEvent(LoadCurrentlyReadingBookEvent event,
      Emitter<EBookStoreState> emit) async {
    emit(state.copyWith(currentlyReadingState: CurrentlyReadingState.loading));

    final response = await dio.get("$currentlyReadingUrl.json");

    if (response.data == null || response.data.isEmpty) {
      emit(state.copyWith(
        currentlyReadingState: CurrentlyReadingState.none,
        currentlyReadingBooks: [],
        currentlyReadingBook: null,
      ));
      return;
    }

    final bookData = response.data as Map<String, dynamic>;
    final List<BookModel> books = bookData.entries.map((entry) {
      final value = entry.value;
      return BookModel(
        id: value["id"],
        title: value["title"],
        author: value["author"],
        price: value["price"] ?? 0.0,
        imageUrl: value["imageUrl"] ?? "",
        currentlyReading: value["currentlyReading"] ?? false,
      );
    }).toList();

    // Encontramos el libro marcado como currentlyReading
    BookModel? currentlyReadingBook;

    try {
      currentlyReadingBook = books.firstWhere((book) => book.currentlyReading);
    } catch (e) {
      currentlyReadingBook = null; // Si no hay ninguno, asignamos null.
    }

    emit(state.copyWith(
      currentlyReadingState: CurrentlyReadingState.success,
      currentlyReadingBooks: books,
      currentlyReadingBook: currentlyReadingBook,
    ));
  }
}
