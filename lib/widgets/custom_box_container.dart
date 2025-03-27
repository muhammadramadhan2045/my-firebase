import 'package:flutter/material.dart';

class CustomBoxContainer extends StatelessWidget {
  const CustomBoxContainer({
    super.key,
    this.isWithShadow = true,
    this.clipBehavior = Clip.none,
    required this.child,
    this.padding,
    this.margin = const EdgeInsets.fromLTRB(24, 0, 24, 16),
    this.backgroudColor,
  });

  final bool isWithShadow;
  final Clip clipBehavior;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets margin;
  final Color? backgroudColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: backgroudColor ?? Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: isWithShadow
            ? const [
                BoxShadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 6.0,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
