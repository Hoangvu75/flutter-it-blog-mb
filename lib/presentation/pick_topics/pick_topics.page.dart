import 'package:flutter/material.dart';

class PickTopicsPage extends StatelessWidget {
  const PickTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Topics'),
      ),
      body: const Center(
        child: Text('Pick Topics'),
      ),
    );
  }
}
