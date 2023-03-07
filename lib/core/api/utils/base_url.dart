import 'package:flutter_dotenv/flutter_dotenv.dart';

const baseUrl = "imdb8.p.rapidapi.com";
const topRatedShowsEncodedPAth = "/title/get-top-rated-tv-shows";
const getNews = "title/get-news";
final apiHeaders = {
  "content-type": "application/json",
  "X-RapidAPI-Key": "${dotenv.env["key_for_imdb"]}",
  "X-RapidAPI-Host": "imdb8.p.rapidapi.com"
};
