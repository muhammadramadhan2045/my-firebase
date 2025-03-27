import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    super.key,
    required this.menuName,
    required this.menuIcon,
  });

  final String menuName;
  final IconData menuIcon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        autofocus: true,
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Icon(
                  menuIcon,
                  size: 25,
                ),
              ),
              Text(
                menuName,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
