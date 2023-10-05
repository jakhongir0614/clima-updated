import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 30.0,
);

const kButtonTextStyle =
    TextStyle(fontSize: 30.0, fontFamily: 'Spartan MB', color: Colors.white);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
const kInputStyle = InputDecoration(
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
    size: 50,
  ),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10))),
  hintText: ('Enter your city'),
  hintStyle: TextStyle(color: Colors.blueGrey),
);
