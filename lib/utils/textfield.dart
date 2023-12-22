import 'package:flutter/material.dart';

Widget textfieledCustom(
  //String? titile,
  String? hintext,
controller,
  TextInputType? type,
  //String? Function(String?) validator
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Text(
      //  titile!,
      //   style: TextStyle(
      //       color: Color.fromARGB(255, 162, 163, 164),
      //       fontSize: 14,
      //       fontWeight: FontWeight.w600),
      // ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
//validator: validator,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 162, 163, 164))),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintext,
            hintStyle:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 138, 138, 138)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red))),
      )
    ],
  );
}
