import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imdb_clone/theme/themes.dart';
import 'home/home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    theme: appTheme,
    home: const Home(),
  ));
}
