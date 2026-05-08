import 'package:flutter/material.dart';

/// 🔹 Input Field Widget (method)
Widget inputField(
    String label,
    IconData icon, {
      int maxLines = 1,
      TextInputType keyboardType = TextInputType.text,
      TextEditingController? controller,
    }) {
  return TextField(
    controller: controller,
    maxLines: maxLines,
    keyboardType: keyboardType,
    style: TextStyle(color: Color(0xFF333333)),

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

    menuMaxHeight: 250, // 👈 dropdown list height control
    //itemHeight: 50,     // 👈 compact items

    dropdownColor: Colors.white,
    elevation: 3,
    borderRadius: BorderRadius.circular(10),

    items: items.map((e) {
      return DropdownMenuItem(
        value: e,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            e,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400, // no bold
             // fontSize: 14,
              color: Color(0xFF333333),
            ),
          ),
        ),
      );
    }).toList(),

    onChanged: items.isEmpty ? null : onChanged,

    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color(0xFF333333)),

      isDense: true, // 👈 compact height

      contentPadding:
      EdgeInsets.symmetric(vertical: 15, horizontal: 15),

      filled: true,
      fillColor: Colors.grey.shade100,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF333333), width: 2),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF0d6efd), width: 2),
      ),
    ),
  );
}
