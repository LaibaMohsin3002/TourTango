// widgets/custom_search_bar.dart
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBar(
      {super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Search tour packages...',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
