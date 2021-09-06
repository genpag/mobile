import 'package:flutter/material.dart';

class RoundedCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  final double size;
  final bool isTappable;
  final bool enabled;

  RoundedCheckbox({
    @required this.value,
    @required this.onChanged,
    this.size = 15,
    this.isTappable = true,
    this.enabled = true,
  });

  @override
  State<StatefulWidget> createState() => _RoundedCheckboxState(value: value);
}

class _RoundedCheckboxState extends State<RoundedCheckbox> {
  bool value;

  _RoundedCheckboxState({
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: widget.isTappable && widget.enabled
          ? () {
              setState(() {
                value = !value;
                widget.onChanged(value);
              });
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: value ? Colors.green : Colors.grey,
          ),
          color: value ? Colors.green : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: value
                ? Icon(
                    Icons.check,
                    size: widget.size,
                    color: Colors.white,
                  )
                : SizedBox(
                    height: widget.size,
                    width: widget.size,
                  ),
          ),
        ),
      ),
    );
  }
}
