part of 'e_book_store_bloc.dart';

enum ExploreScreenState {
  none,
  loading,
  success,
  failure,
}

enum CartScreenState {
  none,
  loading,
  success,
  failure,
}

enum FavoriteScreenState {
  none,
  loading,
  success,
  failure,
}

enum PurchasedScreenState {
  none,
  loading,
  success,
  failure,
}

enum AdminScreenState {
  none,
  loading,
  success,
  failure,
  bookAdded,
  bookUpdated
}

enum CurrentlyReadingState {
  none,
  loading,
  success,
  failure,
}

class EBookStoreState extends Equatable {
  final List<BookModel> allBooks;
  final List<BookModel> purshasedBooks;
  final List<BookModel> trendingBooks;
  final List<BookModel> bookmarked;
  final List<BookModel> cart;
  final List<BookModel> currentlyReadingBooks;
  final ExploreScreenState exploreScreenState;
  final CartScreenState cartScreenState;
  final FavoriteScreenState favoriteScreenState;
  final PurchasedScreenState purchasedScreenState;
  final AdminScreenState adminScreenState;
  final CurrentlyReadingState currentlyReadingState;
  final BookModel? currentlyReadingBook;

  const EBookStoreState({
    required this.allBooks,
    required this.purshasedBooks,
    required this.trendingBooks,
    required this.bookmarked,
    required this.cart,
    required this.currentlyReadingBooks,
    required this.exploreScreenState,
    required this.cartScreenState,
    required this.favoriteScreenState,
    required this.adminScreenState,
    required this.purchasedScreenState,
    required this.currentlyReadingState,
    required this.currentlyReadingBook,
  });

  factory EBookStoreState.initial() {
    return const EBookStoreState(
      allBooks: [],
      purshasedBooks: [],
      trendingBooks: [],
      bookmarked: [],
      cart: [],
      currentlyReadingBooks: [],
      favoriteScreenState: FavoriteScreenState.none,
      exploreScreenState: ExploreScreenState.none,
      cartScreenState: CartScreenState.none,
      adminScreenState: AdminScreenState.none,
      purchasedScreenState: PurchasedScreenState.none,
      currentlyReadingState: CurrentlyReadingState.none,
      currentlyReadingBook: null,
    );
  }

  EBookStoreState copyWith({
    List<BookModel>? allBooks,
    List<BookModel>? purshasedBooks,
    List<BookModel>? trendingBooks,
    List<BookModel>? bookmarked,
    List<BookModel>? cart,
    List<BookModel>? currentlyReadingBooks,
    ExploreScreenState? exploreScreenState,
    CartScreenState? cartScreenState,
    FavoriteScreenState? favoriteScreenState,
    AdminScreenState? adminScreenState,
    PurchasedScreenState? purchasedScreenState,
    CurrentlyReadingState? currentlyReadingState,
    BookModel? currentlyReadingBook,
  }) {
    return EBookStoreState(
      allBooks: allBooks ?? this.allBooks,
      purshasedBooks: purshasedBooks ?? this.purshasedBooks,
      trendingBooks: trendingBooks ?? this.trendingBooks,
      bookmarked: bookmarked ?? this.bookmarked,
      cart: cart ?? this.cart,
      currentlyReadingBooks:
          currentlyReadingBooks ?? this.currentlyReadingBooks,
      exploreScreenState: exploreScreenState ?? this.exploreScreenState,
      cartScreenState: cartScreenState ?? this.cartScreenState,
      favoriteScreenState: favoriteScreenState ?? this.favoriteScreenState,
      adminScreenState: adminScreenState ?? this.adminScreenState,
      purchasedScreenState: purchasedScreenState ?? this.purchasedScreenState,
      currentlyReadingState:
          currentlyReadingState ?? this.currentlyReadingState,
      currentlyReadingBook: currentlyReadingBook ?? this.currentlyReadingBook,
    );
  }

  @override
  List<Object?> get props => [
        allBooks,
        purshasedBooks,
        trendingBooks,
        bookmarked,
        cart,
        currentlyReadingBooks,
        exploreScreenState,
        cartScreenState,
        favoriteScreenState,
        adminScreenState,
        purchasedScreenState,
        currentlyReadingState,
        currentlyReadingBook,
      ];
}
