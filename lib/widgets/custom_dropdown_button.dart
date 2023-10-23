import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/app_color.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.labelText,
    required this.items,
    this.onChanged,
  });

  final List<String> items;
  final String labelText;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: items.first,
      icon: const Icon(Icons.arrow_drop_down),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColor.blue,
        ),
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
      ),
      style: TextStyle(color: AppColor.blue, fontSize: 18),
      autofocus: false,
    );
  }
}
