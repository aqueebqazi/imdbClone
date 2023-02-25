import 'package:flutter/material.dart';
import 'package:imdb_clone/theme/themes.dart';
import 'home/home.dart';

void main() {
  runApp(MaterialApp(
    theme: appTheme,
    home: const Home(),
  ));
}
