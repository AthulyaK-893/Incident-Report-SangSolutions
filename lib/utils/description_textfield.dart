import 'package:flutter/material.dart';

Widget descriptionTextField(String hintText) {
  return Container(
    height: 120,
    child: TextField(
      // controller: _addReviewController,

      style: TextStyle(color: Colors.black),
      maxLines: 10,
      // expands: true,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 138, 138, 138)),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 162, 163, 164),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 162, 163, 164),
            ),
            borderRadius: BorderRadius.circular(16),
          )
          ),
    ),
  );
}
