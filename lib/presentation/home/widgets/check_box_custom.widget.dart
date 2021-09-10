import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckboxWidget extends StatelessWidget {
  final Color color;
  final Rx<bool> selected;
  final Function() onChanged;

  const CheckboxWidget({
    @required this.selected,
    @required this.onChanged,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          Get.focusScope?.unfocus();
          onChanged();
        },
        child: Container(
          width: 25,
          height: 25,
          padding: const EdgeInsets.all(1.6),
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            color: Colors.white,
            child: Visibility(
              visible: selected.value,
              child: Icon(
                Icons.check,
                size: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
