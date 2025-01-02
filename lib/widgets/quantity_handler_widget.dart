import 'package:ebook_store_ag/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class QuantityHandlerWidget extends StatefulWidget {
  final int initialQuantity;
  final int maxQuantity;
  final ValueChanged<int> onQuantityChanged;

  const QuantityHandlerWidget({
    super.key,
    required this.initialQuantity,
    required this.maxQuantity,
    required this.onQuantityChanged,
  });

  @override
  State<QuantityHandlerWidget> createState() => _QuantityHandlerWidgetState();
}

class _QuantityHandlerWidgetState extends State<QuantityHandlerWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
    widget.onQuantityChanged(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (quantity > 1) {
              _updateQuantity(quantity - 1);
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.lightGreen,
            ),
            child: Center(
              child: Text(
                "-",
                style: TextStyle(color: AppColor.black, fontSize: 24),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          quantity.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            if (quantity < widget.maxQuantity) {
              _updateQuantity(quantity + 1);
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.lightGreen,
            ),
            child: Center(
              child: Text(
                "+",
                style: TextStyle(color: AppColor.black, fontSize: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
