import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/app_color.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({
    super.key,
    required this.labelText,
    required this.items,
  });

  final List<String> items;
  final String labelText;

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
      onChanged: (b) {},
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppColor.blue,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: AppColor.blue,
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
