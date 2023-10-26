import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoices_app/style/app_color.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.labelText,
    this.maxLength = 1000,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.onChanged,
    this.onFocusChanged,
    this.validator,
    this.initialValue,
    this.isEnabled = true,
    this.onTap,
    this.sufixIcon,
  });

  final String labelText;
  final int maxLength;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(bool hasFocus)? onFocusChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool isEnabled;
  final void Function()? onTap;

  final Widget? sufixIcon;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() => setState(() {}));
    if (widget.onFocusChanged != null) {
      _focusNode.addListener(() => widget.onFocusChanged!(_focusNode.hasFocus));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
        labelText: widget.labelText,
        counterText: '',
        filled: true,
        fillColor: Colors.white,
        suffixIcon: widget.sufixIcon,
        suffixIconColor: _focusNode.hasFocus ? AppColor.navy : AppColor.blue,
        floatingLabelStyle: TextStyle(color: AppColor.navy),
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: AppColor.navy,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        labelStyle: const TextStyle(
          color: AppColor.blue,
        ),
      ),
      style: TextStyle(color: AppColor.blue, fontSize: 18),
      onChanged: widget.onChanged,
      validator: widget.validator,
      inputFormatters: [
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
      ],
      initialValue: widget.initialValue,
      enabled: widget.isEnabled,
      onTap: widget.onTap,
    );
  }
}
