import 'package:flutter/material.dart';

class DemoTab extends StatelessWidget {
  final String text;
  const DemoTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
