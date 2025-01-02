import 'package:ebook_store_ag/pages/bookmark_page.dart';
import 'package:ebook_store_ag/pages/explore_page.dart';
import 'package:ebook_store_ag/pages/reading_page.dart';
import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> _pages = const [
    ExplorePage(),
    ReadingPage(),
    BookmarkPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.green,
      body: _pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.lightGreen,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          width: double.infinity,
          height: size.width * .18,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _itemBottomMenu(
                    onTap: () => onItemTapped(0),
                    isActive: selectedIndex == 0,
                    title: "Explore",
                    image: const Svg("assets/icons/explore.svg")),
                _itemBottomMenu(
                    onTap: () => onItemTapped(1),
                    isActive: selectedIndex == 1,
                    title: "Reading",
                    image: const Svg("assets/icons/book.svg")),
                _itemBottomMenu(
                    onTap: () => onItemTapped(2),
                    isActive: selectedIndex == 2,
                    title: "Bookmark",
                    image: const Svg("assets/icons/bookmark.svg")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _itemBottomMenu({
  required Function() onTap,
  required bool isActive,
  required String title,
  required ImageProvider image,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image(
              image: image,
              height: 20,
              color: isActive ? AppColor.darkPink : AppColor.green),
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColor.darkPink : AppColor.green),
          )
        ],
      ),
    ),
  );
}
