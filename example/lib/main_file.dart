import 'package:flutter/material.dart';

void fn() {
  print('Hello, World!');
  print("aaa");
}

// expect_lint: class_match_file_name
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FileHasADifferentNameButPrivateClass();
  }
}

class QQQUHJQJ extends StatelessWidget {
  const QQQUHJQJ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _FileHasADifferentNameButPrivateClass extends StatelessWidget {
  const _FileHasADifferentNameButPrivateClass();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
