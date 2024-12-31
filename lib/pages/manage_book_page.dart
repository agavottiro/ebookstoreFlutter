import 'package:ebook_store_ag/model/book_model.dart';
import 'package:ebook_store_ag/pages/bloc/e_book_store_bloc.dart';
import 'package:ebook_store_ag/widgets/app_bar_widget.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ManageBookPage extends StatefulWidget {
  final BookModel? bookModel;
  final bool isEditMode;

  const ManageBookPage({
    super.key,
    this.bookModel,
    this.isEditMode = false,
  });

  @override
  State<ManageBookPage> createState() => _ManageBookPageState();
}

class _ManageBookPageState extends State<ManageBookPage> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _authorCtrl = TextEditingController();
  final TextEditingController _imageUrlCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();

  @override
  void initState() {
    if (widget.isEditMode) {
      setState(() {
        _titleCtrl.text = widget.bookModel!.title;
        _authorCtrl.text = widget.bookModel!.author;
        _imageUrlCtrl.text = widget.bookModel!.imageUrl;
        _priceCtrl.text = widget.bookModel!.price.toString();
      });
    }
    super.initState();
  }

  _addBook(BuildContext context) {
    context.read<EBookStoreBloc>().add(CreateNewBookEvent(
          title: _titleCtrl.text,
          author: _authorCtrl.text,
          imageUrl: _imageUrlCtrl.text,
          price: double.parse(_priceCtrl.text.toString()),
        ));
    _titleCtrl.clear();
    _authorCtrl.clear();
    _imageUrlCtrl.clear();
    _priceCtrl.clear();

    Navigator.pop(context);
  }

  _editBook(BuildContext context) {
    context.read<EBookStoreBloc>().add(EditBookEvent(
          title: _titleCtrl.text,
          author: _authorCtrl.text,
          imageUrl: _imageUrlCtrl.text,
          price: double.parse(_priceCtrl.text.toString()),
          id: widget.bookModel!.id,
        ));
    _titleCtrl.clear();
    _authorCtrl.clear();
    _imageUrlCtrl.clear();
    _priceCtrl.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundGreen,
      appBar: AppBarWidget(
        title: widget.isEditMode ? "Edit book" : "Add book",
        image: const Svg("assets/icons/settings.svg"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextFormField(
                controller: _authorCtrl,
                decoration: const InputDecoration(labelText: "Author"),
              ),
              TextFormField(
                controller: _imageUrlCtrl,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _priceCtrl,
                decoration: const InputDecoration(labelText: "Price"),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (widget.isEditMode) {
                      _editBook(context);
                    } else {
                      _addBook(context);
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(AppColor.lightPink),
                      foregroundColor:
                          WidgetStateProperty.all(AppColor.darkPink)),
                  child: Text(widget.isEditMode ? "Save changes" : "Add book")),
            ],
          ),
        ),
      ),
    );
  }
}
