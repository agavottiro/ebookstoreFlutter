import 'package:ebook_store_ag/model/book_model.dart';

import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:ebook_store_ag/widgets/stars_widget.dart';
import 'package:flutter/material.dart';

class ContinueReadingWidget extends StatelessWidget {
  final BookModel? book;
  const ContinueReadingWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: Container(
        width: double.infinity,
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.lightGreen,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: book == null
              ? Center(
                  child: Text(
                    "You're not reading any book right now",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.darkPink),
                  ),
                )
              : Row(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image(
                        image: NetworkImage(book!.imageUrl),
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
                            book!.title,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          Text("by ${book!.author}"),
                          const StarsWidget(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox.square(
                            dimension: 50,
                            child: CircularProgressIndicator(
                              value: 1,
                              color: AppColor.green,
                              strokeWidth: 8,
                            ),
                          ),
                          SizedBox.square(
                            dimension: 50,
                            child: CircularProgressIndicator(
                              value: .65,
                              color: AppColor.darkPink,
                              strokeWidth: 8,
                            ),
                          ),
                          const Text(
                            '65%',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
