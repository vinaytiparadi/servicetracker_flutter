import 'package:flutter/material.dart';

//height
double scHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//width
double scWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

OutlineInputBorder outlineEnabledBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.4)),
  );
}
