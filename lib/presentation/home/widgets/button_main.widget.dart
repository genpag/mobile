import 'package:flutter/material.dart';

class ButtonMainWidget extends StatelessWidget {
  final Function() onPressed;
  final String texto;
  final Color colorText, colorBackground;
  final bool isEnable;
  ButtonMainWidget({
    @required this.onPressed,
    @required this.texto,
    this.colorText = const Color(0xFFF6F6F6),
    this.colorBackground = const Color(0xFFFF8D2D),
    this.isEnable = true,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            isEnable ? colorBackground : Color(0xFFF6F6F6),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            texto,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isEnable ? colorText : Color(0xFFA3A3A3),
            ),
          ),
        ),
      ),
    );
  }
}
