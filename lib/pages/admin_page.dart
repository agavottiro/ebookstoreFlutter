import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/pages/manage_book_page.dart';
import 'package:ebook_store_ag/widgets/app_bar_widget.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundGreen,
      appBar: const AppBarWidget(
        title: "Admin Dashboard",
        cartDisable: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ManageBookPage())),
        backgroundColor: AppColor.lightPink,
        child: Image(
          image: const Svg("assets/icons/add.svg"),
          color: AppColor.darkPink,
        ),
      ),
      body: BlocBuilder<EBookStoreBloc, EBookStoreState>(
        builder: (context, state) {
          return Expanded(
            child: ListView.builder(
                itemCount: state.allBooks.length,
                itemBuilder: (context, index) {
                  final book = state.allBooks[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    leading: GestureDetector(
                      onTap: () {
                        context
                            .read<EBookStoreBloc>()
                            .add(RemoveBookEvent(book: book));
                      },
                      child: Image(
                        image: const Svg("assets/icons/delete.svg"),
                        color: AppColor.red,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageBookPage(
                                    isEditMode: true,
                                    bookModel: state.allBooks[index],
                                  ))),
                      child: Image(
                        image: const Svg("assets/icons/edit.svg"),
                        color: AppColor.green,
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
