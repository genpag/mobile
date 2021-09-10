import 'package:flutter/material.dart';

class HeaderHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'March 9, 2020',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '5 incomplete, 5 completed',
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
        const SizedBox(height: 8),
        Divider(),
      ],
    );
  }
}
