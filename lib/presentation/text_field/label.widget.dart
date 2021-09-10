import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final bool requiredField;
  final Color colorRequired, colorLabel;
  const LabelWidget({
    @required this.label,
    this.requiredField = false,
    this.colorRequired,
    this.colorLabel,
  });

  @override
  Widget build(BuildContext context) {
    const fontSize = 14.0;
    final double size = (label.length * fontSize) + 7;
    return SizedBox(
      width: size,
      child: Row(
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: colorLabel ?? Color(0xFF464646),
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Visibility(
            visible: requiredField,
            child: Text(
              '*',
              style: TextStyle(
                color: colorRequired ?? Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
