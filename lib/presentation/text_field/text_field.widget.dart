import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'label.widget.dart';
import 'text_field_type.enum.dart';

class TextFieldWidget extends StatelessWidget {
  final bool enabled;
  final RxBool upperCase;
  final double percentualWidth;
  final InputDecoration decoration;
  final Color colorRequired, colorLabel, colorIconData, colorBackgroundField;
  final colorsBorder = const Color(0xFFECECEC);
  final EdgeInsets contentPadding;
  final TextFieldType type;
  final String label;
  final bool isRequired;
  final dynamic value;
  final TextEditingController _maskController;
  final void Function(DateTime) onChangeDate;

  TextFieldWidget({
    @required this.type,
    this.onChangeDate,
    this.enabled = true,
    this.label,
    this.isRequired = false,
    this.percentualWidth,
    this.decoration,
    this.upperCase,
    this.value,
    this.colorRequired,
    this.colorLabel,
    this.colorIconData,
    this.colorBackgroundField,
    this.contentPadding = const EdgeInsets.all(14),
  }) : _maskController = TextEditingController() {
    setInitialValue();
  }

  void setInitialValue() {
    switch (type) {
      case TextFieldType.TEXT:
        _maskController.text = value.value as String;
        return;
      case TextFieldType.INT:
        _maskController.text = '${value.value}';
        return;
      default:
    }

    if (value is Rx<DateTime> && value.value != null) {
      _maskController.text = DateFormat('dd/MM/yyyy').format(
        (value as Rx<DateTime>).value,
      );
    }
  }

  Widget chooseTextField() {
    switch (type) {
      case TextFieldType.TEXT:
      case TextFieldType.TEXT_AREA:
      case TextFieldType.INT:
        return _TextFieldWidget(
          colorsBorder: colorsBorder,
          enabled: enabled,
          value: value,
          type: type,
          maskController: _maskController,
          contentPadding: contentPadding,
          decoration: decoration,
          upperCase: upperCase,
          colorBackgroundField: colorBackgroundField,
        );
      case TextFieldType.DATE:
        return _DateFieldWidget(
          colorsBorder: colorsBorder,
          value: value,
          maskController: _maskController,
          contentPadding: contentPadding,
          decoration: decoration,
          colorBackgroundField: colorBackgroundField,
        );

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: LabelWidget(
              label: label,
              requiredField: isRequired,
              colorLabel: colorLabel,
              colorRequired: colorRequired,
            ),
          )
        else
          const SizedBox(),
        SizedBox(
          width: percentualWidth != null
              ? MediaQuery.of(context).size.width * percentualWidth
              : double.infinity,
          child: chooseTextField(),
        ),
      ],
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final bool enabled;
  final Color colorsBorder;
  final TextEditingController maskController;
  final Color colorBackgroundField;
  final EdgeInsets contentPadding;
  final InputDecoration decoration;
  final RxBool upperCase;
  final TextFieldType type;
  final dynamic value;

  const _TextFieldWidget({
    @required this.maskController,
    @required this.enabled,
    @required this.colorsBorder,
    @required this.contentPadding,
    @required this.type,
    @required this.value,
    this.decoration,
    this.upperCase,
    this.colorBackgroundField,
  });

  List<TextInputFormatter> getInputFormatters() {
    if (type == TextFieldType.INT) {
      return [FilteringTextInputFormatter.digitsOnly];
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (_) {
        if (type == TextFieldType.INT) {
          value.value = int.parse(maskController.text);
        } else {
          value.value = maskController.text;
        }
      },
      controller: maskController,
      enabled: enabled,
      maxLines: type == TextFieldType.TEXT_AREA ? 4 : 1,
      inputFormatters: getInputFormatters(),
      textAlign: type == TextFieldType.INT ? TextAlign.end : TextAlign.start,
      decoration: decoration ??
          InputDecoration(
            isDense: true,
            fillColor: colorBackgroundField,
            filled: true,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: colorsBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: colorsBorder),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: colorsBorder),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
    );
  }
}

class _DateFieldWidget extends StatelessWidget {
  final dynamic value;
  final TextEditingController maskController;
  final Color colorsBorder;
  final Color colorIconData, colorBackgroundField;
  final EdgeInsets contentPadding;
  final InputDecoration decoration;

  final void Function(DateTime) onChange;

  const _DateFieldWidget({
    @required this.value,
    @required this.maskController,
    @required this.colorsBorder,
    @required this.contentPadding,
    this.decoration,
    this.onChange,
    this.colorIconData,
    this.colorBackgroundField,
  });

  Future<void> openDatePicker() async {
    Get.focusScope?.unfocus();

    final initialValue = value as Rx<DateTime>;

    final result = await showDatePicker(
      context: Get.context,
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
      initialDate:
          initialValue.value == null ? DateTime.now() : initialValue.value,
    );

    initialValue.value = result;
    onChange?.call(result);
    if (initialValue.value != null) {
      maskController.text = DateFormat('dd/MM/yyyy').format(
        initialValue.value,
      );
    } else {
      maskController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: InkWell(
            onTap: openDatePicker,
            child: TextFormField(
              controller: maskController,
              enabled: false,
              decoration: decoration ??
                  InputDecoration(
                    isDense: true,
                    fillColor: colorBackgroundField,
                    filled: true,
                    contentPadding: contentPadding,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: colorsBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: colorsBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: colorsBorder),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: .5,
                color: Colors.black,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: openDatePicker,
          icon: const Icon(Icons.date_range),
          color: colorIconData ?? const Color(0xFFAABCAA),
          iconSize: 22,
          splashRadius: 20,
        )
      ],
    );
  }
}
