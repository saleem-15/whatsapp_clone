// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';

class SearchableList<T> extends StatefulWidget {
  SearchableList({
    super.key,
    required this.list,
    required this.itemBuilder,
    required this.textController,
    this.isSearchMode = false,
    required this.filterFunction,
  }) {
    if (isSearchMode) {
      _filteredList = filterFunction(list);
    }
  }

  final List<T> list;
  final Widget Function(T item) itemBuilder;
  final List<T> Function(List<T> list) filterFunction;
  final TextEditingController textController;
  final bool isSearchMode;
  List<T>? _filteredList;

  @override
  State<SearchableList<T>> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {

  @override
  void initState() {
    // if (widget.isSearchMode) {
    //   widget._filteredList = widget.filterFunction(widget.list);
    // }
    widget.textController.addListener(() {
      log('text changed: ${widget.textController.text}');
      widget._filteredList = widget.filterFunction(widget.list);
      length = widget.isSearchMode ? widget._filteredList!.length : widget.list.length;
      log('length $length');
      setState(() {});
    });

    super.initState();
  }

  late int length = widget.isSearchMode ? widget._filteredList!.length : widget.list.length;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: _listElementBuilder,
    );
  }

  Widget _listElementBuilder(BuildContext context, int index) {
    /// if its search mode => take the element from widget.[_filteredList]
    /// not search mode => take the element from [list]

    T item = widget.isSearchMode ? widget._filteredList![index] : widget.list[index];

    return widget.itemBuilder(item);
  }
}
