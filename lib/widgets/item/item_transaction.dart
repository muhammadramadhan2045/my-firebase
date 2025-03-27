import 'package:flutter/material.dart';

class ItemTransaction extends StatelessWidget {
  const ItemTransaction({
    super.key,
    required this.iconLeading,
    required this.textTitle,
    required this.textSubtitle,
  });
  final IconData iconLeading;
  final String textTitle;
  final String textSubtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(
          iconLeading,
          color: Colors.white,
        ),
      ),
      title: Text(textTitle),
      subtitle: Text(textSubtitle),
    );
  }
}
