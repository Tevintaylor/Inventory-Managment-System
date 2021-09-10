import 'package:flutter/material.dart';

//to make text decorstions unique when using this, got to places of use and use "copyWith(hintText:'specific text"
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)),
);
