import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb_clone/home/model/top_rated_shows_model.dart';
import 'package:imdb_clone/http/http_utils.dart';
import 'package:imdb_clone/utils/base_url.dart';

import '../model/get_id_model.dart';

class HomeController extends GetxController {
  List<GetShowId> showId = [];
  List apiResult = [];
  List<TvShowApi> topRatedShows = [];
  List<TvShowApi> upcoming = [];
  List<TvShowApi> popular = [];
  List<TvShowApi> nowPlaying = [];
  List tabNames = ["Now playing", "Upcoming", "Popular", "Top Rated"];
  List<TvShowApi> tvShowData = [];
  bool isloading = true;
  bool isError = false;

  getNewsApi() async {
    try {
      isError = false;
      isloading = true;
      log("newsApiStaretd");

      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[0].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      tvShowData = newsOfTvShows.map((e) {
        log(e.toString());
        return TvShowApi.fromJson(e);
      }).toList();
      isloading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isErrorNewsApi" + isError.toString());
      isError = true;
      isloading = false;
      update();
    }
    log("newsApiEnd");
  }

  getTopRatedShows() async {
    try {
      isError = false;
      isloading = true;
      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[1].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      topRatedShows = newsOfTvShows.map((e) {
        log(e.toString());
        return TvShowApi.fromJson(e);
      }).toList();
      isloading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isloading = false;
      update();
    }
  }

  getUpcoming() async {
    try {
      isError = false;
      isloading = true;
      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[2].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      upcoming = newsOfTvShows.map((e) {
        log(e.toString());
        return TvShowApi.fromJson(e);
      }).toList();
      isloading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isloading = false;
      update();
    }
  }

  getPopluar() async {
    try {
      isError = false;
      isloading = true;
      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[3].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      popular = newsOfTvShows.map((e) {
        log(e.toString());
        return TvShowApi.fromJson(e);
      }).toList();
      isloading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isloading = false;
      update();
    }
  }

  getNowPlaying() async {
    try {
      isError = false;
      isloading = true;
      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[4].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      nowPlaying = newsOfTvShows.map((e) {
        log(e.toString());
        return TvShowApi.fromJson(e);
      }).toList();
      isloading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isloading = false;
      update();
    }
  }

  getShowID() async {
    try {
      isError = false;
      apiResult = await getApi(baseUrl, apiHeaders, topRatedShowsEncodedPAth);
      showId = apiResult.map((e) {
        return GetShowId.FromJson(e);
      }).toList();
      log("showIDfetched");
      getNewsApi();
      update();
    } catch (e) {
      isError = true;
      update();
    }
  }
}
