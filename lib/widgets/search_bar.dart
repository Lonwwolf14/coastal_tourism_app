import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Widget leading;

  const CustomSearchBar({
    Key? key,
    required this.hintText,
    this.onChanged,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: leading,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
