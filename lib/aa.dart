import 'package:flutter/material.dart';

// expected: A lint here
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Should be at least 1 lint error');
  }
}
