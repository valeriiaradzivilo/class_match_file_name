import 'package:flutter/material.dart';

void fn() {
  print('Hello, World!');
  print("aaa"); 
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FileHasADifferentNameButPrivateClass();
  }
}

class _FileHasADifferentNameButPrivateClass extends StatelessWidget {
  const _FileHasADifferentNameButPrivateClass();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



