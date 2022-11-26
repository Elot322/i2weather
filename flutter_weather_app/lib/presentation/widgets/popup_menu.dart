import 'package:flutter/material.dart';

class ChangePeriodMenu extends StatelessWidget {
  static const menuItems = <String>['24 hour', '5 days'];

  final Iterable<PopupMenuItem<String>> _items = menuItems.map(
    (String value) => PopupMenuItem<String>(
      child: Text(value),
      value: value,
    ),
  );
  @override
  Widget build(Object context) {
    return PopupMenuButton<String>(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) => _items.toList());
  }
}
