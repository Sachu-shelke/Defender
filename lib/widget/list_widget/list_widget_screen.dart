// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/textfields/search_textfield.dart';

class ListScreen extends StatefulWidget {
  final List<dynamic> list;
  final String title;
  const ListScreen({required this.list, super.key, required this.title});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<dynamic>? _modelList;
  List<dynamic>? _searchList;
  bool _isSearchAble = true;

  @override
  void initState() {
    super.initState();
    _modelList = widget.list
      ..sort((a, b) {
        return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
      });
    _searchList = _modelList;
    _isSearchAble = true;
  }

  void _textChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _searchList = _modelList!
            .where((element) =>
                element.name!.toLowerCase().contains(text.trim().toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _searchList!.clear();
        _searchList!.addAll(_modelList!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select ${widget.title}',
      ),
      body: Column(
        children: [
          SearchTextField(
            isSearchAble: _isSearchAble,
            textChanged: _textChanged,
            placeHolder: widget.title,
          ),
          if (_modelList != null)
            Expanded(
              child: ListView.builder(
                itemCount: _searchList!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pop(_searchList![index]);
                    },
                    title: Text(
                      _searchList![index].name!,
                      textScaleFactor: 1.0,
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
