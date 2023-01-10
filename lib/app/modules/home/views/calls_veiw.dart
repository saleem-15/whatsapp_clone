import 'dart:developer';

import 'package:flutter/material.dart';

class CallsView extends StatelessWidget {
  const CallsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Calls'),
    );
  }

  void logConstrainsts(BoxConstraints constrains) {
    log('Max Width: ${constrains.maxWidth.toStringAsFixed(1)}\t\t  Min Width: ${constrains.minWidth.toStringAsFixed(1)}');
    log('Max Height: ${constrains.maxHeight.toStringAsFixed(1)}\t\t  Min Height: ${constrains.minHeight.toStringAsFixed(1)}');
  }
}
