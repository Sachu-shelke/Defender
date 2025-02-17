import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final bool? isSearchAble;
  final Function(String)? textChanged;
  final bool autoFocus;
  final String placeHolder;
  final TextEditingController? controller;

  const SearchTextField(
      {super.key,
      required this.isSearchAble,
      required this.textChanged,
      this.autoFocus = false,
      this.placeHolder = "Search Operator",
      this.controller});

  @override
  // ignore: library_private_types_in_public_api
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.textChanged,
        enabled: widget.isSearchAble,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
            hintText: widget.placeHolder,
            prefixIcon: const Icon(
              Icons.search,
            ),
            border: const OutlineInputBorder()),
      ),
    );
  }
}
