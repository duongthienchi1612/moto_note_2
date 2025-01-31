import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_text_field.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String? value;
  final Function(String) onChanged;

  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.textInputType,
    this.inputFormatters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleLarge),
        CustomTextField(
          data: value,
          textInputType: textInputType,
          inputFormatters: inputFormatters,
          onChange: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
