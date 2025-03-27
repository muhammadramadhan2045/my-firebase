import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    String title = '',
    Color? titleStyleColor,
    double? scrolledUnderElevation,
    Color? backgroundColor,
    bool? automaticallyImplyLeading,
    bool? centerTitle,
    Color? colorIcon,
  }) : super(
          centerTitle: centerTitle ?? true,
          scrolledUnderElevation: scrolledUnderElevation ?? 4,
          title: Text(
            title,
            style: TextStyle(
              color: titleStyleColor ?? Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: colorIcon ?? Colors.white,
          ),
          backgroundColor: backgroundColor ?? Colors.white,
          automaticallyImplyLeading: automaticallyImplyLeading ?? true,
        );
}
