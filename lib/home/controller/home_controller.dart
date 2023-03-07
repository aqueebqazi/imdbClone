import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb_clone/home/model/top_rated_shows_model.dart';
import 'package:imdb_clone/core/api/api_call.dart';
import 'package:imdb_clone/core/api/utils/base_url.dart';

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
  bool isNowPlayingLoading = true;
  bool isUpcomingLoading = true;
  bool isPopularLoading = true;
  bool isTopRatedLoading = true;
  bool isError = false;

  getTopTenShows() async {
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
        return TvShowApi.fromJson(e);
      }).toList();
      isloading = false;
      getNowPlaying();
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
    log("GetTopRatedShowsCalled");
    try {
      isTopRatedLoading = true;
      isError = false;
      Future.delayed(Duration(milliseconds: 100));
      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[1].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      topRatedShows = newsOfTvShows.map((e) {
        return TvShowApi.fromJson(e);
      }).toList();

      isTopRatedLoading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isTopRatedLoading = false;
      update();
    }
  }

  getUpcoming() async {
    log("GetUpcomingApiCalled");
    try {
      isUpcomingLoading = true;
      isError = false;

      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[2].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      upcoming = newsOfTvShows.map((e) {
        return TvShowApi.fromJson(e);
      }).toList();
      isUpcomingLoading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isUpcomingLoading = false;
      update();
    }
  }

  getPopluar() async {
    try {
      isPopularLoading = true;
      isError = false;

      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[3].id.substring(6).replaceAll("/", "")
      });
      log("response_is");
      List newsOfTvShows = response["items"];

      popular = newsOfTvShows.map((e) {
        return TvShowApi.fromJson(e);
      }).toList();
      isPopularLoading = false;
      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isPopularLoading = false;
      update();
    }
  }

  getNowPlaying() async {
    try {
      isError = false;
      isNowPlayingLoading = true;
      log("nowPlaying" + isNowPlayingLoading.toString());
      var response = await getApi(baseUrl, apiHeaders, getNews, parms: {
        "limit": "10",
        "tconst": showId[4].id.substring(6).replaceAll("/", "")
      });

      List newsOfTvShows = response["items"];

      nowPlaying = newsOfTvShows.map((e) {
        return TvShowApi.fromJson(e);
      }).toList();
      isNowPlayingLoading = false;

      update();
      log("isError1" + isError.toString());
    } catch (e) {
      log("error" + e.toString());
      log("isError" + isError.toString());
      isError = true;
      isNowPlayingLoading = false;
      update();
    }
  }

  getShowID() async {
    try {
      log("fetch id");
      isError = false;
      apiResult = await getApi(baseUrl, apiHeaders, topRatedShowsEncodedPAth);
      log(apiResult.toString());
      showId = apiResult.map((e) {
        return GetShowId.FromJson(e);
      }).toList();
      log("showIDfetched");
      getTopTenShows();
      log("isEroor" + isError.toString());
      update();
    } catch (e) {
      isError = true;
      update();
    }
  }

  @override
  void onInit() {
    log("init Getx");
    isError = false;
    // TODO: implement onInit
    super.onInit();
  }
}
