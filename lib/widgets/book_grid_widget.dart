import 'package:ebook_store_ag/model/book_model.dart';
import 'package:ebook_store_ag/pages/book_detail_page.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookGridWidget extends StatelessWidget {
  final BookModel book;

  const BookGridWidget({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: SizedBox(
        width: 130,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetailPage(book: book))),
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(book.imageUrl),
                        fit: BoxFit.fitWidth)),
              ),
              Text(
                "by ${book.author}",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                book.title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              Text(
                book.price.toString(),
                style: TextStyle(
                    color: AppColor.darkPink,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    );
  }
}
