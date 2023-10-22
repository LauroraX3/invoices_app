import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoices_app/style/app_color.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.labelText,
    this.maxLength = 1000,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.validator,
    this.initialValue,
  });

  final String labelText;
  final int maxLength;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: AppColor.navy,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: AppColor.darkPink,
          ),
        ),
        labelStyle: const TextStyle(
          color: AppColor.blue,
        ),
      ),
      style: TextStyle(color: AppColor.blue, fontSize: 18),
      onChanged: onChanged,
      validator: validator,
      inputFormatters: [
        if (keyboardType == TextInputType.number)
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
      ],
      initialValue: initialValue,
    );
  }
}
