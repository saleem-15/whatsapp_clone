import 'package:get/get.dart';

extension MyListExtensions<T> on List<T> {
  void safeAdd(T? value) {
    if (value != null) {
      add(value);
    }
  }

  List<Rx<T>> get convertToRxElements {
    return map((e) => e.obs).toList();
  }

  void safeAddAll(List<T>? values) {
    if (values != null) {
      addAll(values);
    }
  }

  ///checks if the string is `empty` or `null` or is only `space`
  bool isBlank(String? x) {
    if (x == null || x.trim().isEmpty) {
      return true;
    }
    return false;
  }
}
