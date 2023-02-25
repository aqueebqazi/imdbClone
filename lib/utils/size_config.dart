import 'package:flutter/material.dart';

class SizeConfig {
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  void init(context) {
    deviceWidth = MediaQuery.of(context).size.width / 375;
    deviceHeight = MediaQuery.of(context).size.height / 812;
  }
}
