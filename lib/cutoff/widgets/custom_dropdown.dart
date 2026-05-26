import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {

  final String hint;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T?) onChanged;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        hint: Text(hint),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}