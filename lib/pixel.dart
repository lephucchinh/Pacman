import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  const MyPixel({super.key, required this.innerColor, required this.outerColor, this.child});
  final Color? innerColor;
  final Color? outerColor;
  final child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.0),
    child: Container(
      decoration: BoxDecoration(
        color: outerColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: innerColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
    );
  }
}
