import 'package:flutter/material.dart';

Widget custombotton(String? name, ontap, double? width) {
  return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        height: 45,
        width: width,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
        child: Text(
          name!,
          style:const TextStyle( color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,)
      ));
}
