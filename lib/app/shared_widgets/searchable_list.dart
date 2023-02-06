import 'package:flutter/material.dart';

/// Whenever the textController changes this widget will
/// change its children according to the output of the
/// filteringFunction that you have prvided as parameters
class SearchableListView<T> extends StatefulWidget {
  final List<T> list;
  final TextEditingController textController;
  final List<T> Function(List<T> list) filteringFunction;
  final Widget Function(T item) itemBuilder;

  const SearchableListView({
    super.key,
    required this.list,
    required this.textController,
    required this.filteringFunction,
    required this.itemBuilder,
  });

  @override
  SearchableListViewState<T> createState() => SearchableListViewState<T>();
}

class SearchableListViewState<T> extends State<SearchableListView<T>> {
  late List<T> filteredList;

  Widget _listElementBuilder(BuildContext context, int index) {
    T item = filteredList[index];
    return widget.itemBuilder(item);
  }

  @override
  void initState() {
    filteredList = widget.list;

    widget.textController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filteredList = widget.filteringFunction(widget.list);
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: _listElementBuilder,
    );
  }
}
