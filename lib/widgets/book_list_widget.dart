import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/stars_widget.dart';
import 'package:flutter/material.dart';

import 'package:ebook_store_ag/model/book_model.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListWidget extends StatefulWidget {
  final BookModel book;
  final String initialReadingState;

  const BookListWidget({
    super.key,
    required this.book,
    required this.initialReadingState,
  });

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  late String readingState;

  @override
  void initState() {
    super.initState();
    readingState = widget.initialReadingState;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EBookStoreBloc, EBookStoreState>(
      listener: (context, state) {
        if (state.currentlyReadingBook?.id == widget.book.id) {
          setState(() {
            readingState = 'Reading';
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.lightGreen,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image(
                    image: NetworkImage(widget.book.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.book.title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text("by ${widget.book.author}"),
                      const SizedBox(height: 4),
                      const StarsWidget()
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                if (readingState == "startReading")
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        readingState = "Reading";
                      });
                      context
                          .read<EBookStoreBloc>()
                          .add(CurrentlyReadingEvent(book: widget.book));
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.darkPink,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Start Reading",
                          style: TextStyle(
                            color: AppColor.lightGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (readingState == "Reading")
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.lightPink,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Reading",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
