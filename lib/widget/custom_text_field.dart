import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CustomTextField extends StatefulWidget {
  final String? data;
  final int? maxLength;
  final bool ignorePointer;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final Function(String) onChange;

  const CustomTextField(
      {this.data,
      required this.onChange,
      this.ignorePointer = false,
      super.key,
      this.inputFormatters,
      this.textInputType,
      this.maxLength});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.data ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadius)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadius)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          counterText: '',
        ),
        maxLength: widget.maxLength,
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        ignorePointers: widget.ignorePointer,
        onChanged: (value) {
          widget.onChange(value);
        },
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
