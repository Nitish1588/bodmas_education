import 'package:flutter/material.dart';

/// 🔹 Input Field Widget (method)
Widget inputField(
    String label,
    IconData icon, {
      int maxLines = 1,
      TextInputType keyboardType = TextInputType.text,
    }) {
  return TextField(
    maxLines: maxLines,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color(0xFF333333)),

      prefixIcon: Icon(icon),

      filled: true,
      fillColor: Colors.grey.shade100,

      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF333333), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF0d6efd), width: 2),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

/// 🔹 Dropdown Widget (method)
Widget dropdownField({
  required String label,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    isExpanded: true,
    initialValue: value,
    items: items
        .map((e) => DropdownMenuItem(
      value: e,
      child: Text(
        e,
        overflow: TextOverflow.ellipsis, // 👈 overflow fix
        maxLines: 1,
      ),
    ))
        .toList(),
    onChanged: items.isEmpty ? null : onChanged,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color(0xFF333333)),


      // icon optional
     // prefixIcon: icon != null ? Icon(icon, color: Color(0xFF333333)) : null,

      filled: true,
      fillColor: Colors.grey.shade100,

      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF333333), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF0d6efd), width: 2),
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}