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

enum AdminScreenState {
  none,
  loading,
  success,
  failure,
  bookAdded,
  bookUpdated
}

class EBookStoreState extends Equatable {
  final List<BookModel> allBooks;
  final List<BookModel> purshasedBooks;
  final List<BookModel> trendingBooks;
  final List<BookModel> bookmarked;
  final List<BookModel> cart;
  final ExploreScreenState exploreScreenState;
  final CartScreenState cartScreenState;
  final AdminScreenState adminScreenState;

  const EBookStoreState({
    required this.allBooks,
    required this.purshasedBooks,
    required this.trendingBooks,
    required this.bookmarked,
    required this.cart,
    required this.exploreScreenState,
    required this.cartScreenState,
    required this.adminScreenState,
  });

  factory EBookStoreState.initial() {
    return const EBookStoreState(
        allBooks: [],
        purshasedBooks: [],
        trendingBooks: [],
        bookmarked: [],
        cart: [],
        exploreScreenState: ExploreScreenState.none,
        cartScreenState: CartScreenState.none,
        adminScreenState: AdminScreenState.none);
  }

  EBookStoreState copyWith({
    List<BookModel>? allBooks,
    List<BookModel>? purshasedBooks,
    List<BookModel>? trendingBooks,
    List<BookModel>? bookmarked,
    List<BookModel>? cart,
    ExploreScreenState? exploreScreenState,
    CartScreenState? cartScreenState,
    AdminScreenState? adminScreenState,
  }) {
    return EBookStoreState(
      allBooks: allBooks ?? this.allBooks,
      purshasedBooks: purshasedBooks ?? this.purshasedBooks,
      trendingBooks: trendingBooks ?? this.trendingBooks,
      bookmarked: bookmarked ?? this.bookmarked,
      cart: cart ?? this.cart,
      exploreScreenState: exploreScreenState ?? this.exploreScreenState,
      cartScreenState: cartScreenState ?? this.cartScreenState,
      adminScreenState: adminScreenState ?? this.adminScreenState,
    );
  }

  @override
  List<Object> get props => [
        allBooks,
        purshasedBooks,
        trendingBooks,
        bookmarked,
        cart,
        exploreScreenState,
        cartScreenState,
        adminScreenState,
      ];
}
