import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final double? borderRadius;
  final int? maxLines;

  const TextFieldWidget(
      {Key? key,
      required this.textController,
      required this.hintText,
      this.borderRadius = 30,
      this.maxLines = 1})
      : super(key: key);
// for optional variable "int? maxLines" we need not use required keyword
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      controller: textController,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.textHolder,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide:
                  const BorderSide(color: AppColors.secondaryColor, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
              borderSide: const BorderSide(color: Colors.white, width: 1))),
    );
  }
}
