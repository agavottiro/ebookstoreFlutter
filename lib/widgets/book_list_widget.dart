import 'package:ebook_store_ag/model/book_model.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class BookListWidget extends StatelessWidget {
  final BookModel book;
  final String readingState;

  const BookListWidget({
    super.key,
    required this.book,
    required this.readingState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.lightGreen),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    Image(image: NetworkImage(book.imageUrl), fit: BoxFit.fill),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text("by ${book.author}"),
                        const Text("* * * * *")
                      ],
                    ),
                    if (readingState == "Reading")
                      Container(
                        width: 70,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColor.lightPink,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "Reading",
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                    if (readingState == "startReading")
                      Container(
                        width: 70,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColor.darkPink,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "Start Reading",
                          style: TextStyle(
                              color: AppColor.lightGreen,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )),
                      ),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
