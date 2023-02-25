import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb_clone/home/controller/home_controller.dart';
import 'package:imdb_clone/home/widgets/common_widget.dart';
import 'package:imdb_clone/home/widgets/home_widgets.dart';
import 'package:imdb_clone/theme/global_styles.dart';
import 'package:imdb_clone/theme/themes.dart';
import 'package:imdb_clone/utils/size_config.dart';

late TabController tabController;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    tabController = TabController(initialIndex: 1, length: 4, vsync: this);
    homeController.getShowID();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: appTheme.primaryColor,
      body: GetBuilder<HomeController>(builder: (con) {
        return homeController.isError == false
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 43 * sizeConfig.deviceHeight,
                        left: 24 * sizeConfig.deviceWidth),
                    child: const Text(
                      "What do you want to watch?",
                      style: homeTitleTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 24 * sizeConfig.deviceWidth,
                        right: 24 * sizeConfig.deviceWidth,
                        top: 24 * sizeConfig.deviceHeight),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: searchHintTextStyle,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              "assets/svg/search.svg",
                              fit: BoxFit.fill,
                              width: 15 * sizeConfig.deviceWidth,
                              height: 16 * sizeConfig.deviceHeight,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xff3A3F47).withOpacity(1),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                    ),
                  ),
                  GetBuilder<HomeController>(builder: (contex) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: 34 * sizeConfig.deviceWidth),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 210 * sizeConfig.deviceHeight,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.tvShowData.length,
                              itemBuilder: (context, index) {
                                var imgurl = homeController
                                    .tvShowData[index].image.url
                                    .toString();
                                return homeController.isloading == false
                                    ? Stack(
                                        children: [
                                          tvShowImage(sizeConfig.deviceWidth,
                                              sizeConfig.deviceHeight, imgurl),
                                          Positioned.fill(
                                            top: 105 * sizeConfig.deviceHeight,
                                            child: Text(
                                              "${index + 1}",
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    foreground: Paint()
                                                      ..style =
                                                          PaintingStyle.stroke
                                                      ..strokeWidth = 1.5
                                                      ..color =
                                                          Color(0xff0296E5),
                                                    fontSize: 96 *
                                                        sizeConfig.deviceWidth),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            top: 105 * sizeConfig.deviceHeight,
                                            child: Text(
                                              "${index + 1}",
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color:
                                                        const Color(0xff3A3F47),
                                                    fontSize: 96 *
                                                        sizeConfig.deviceWidth),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : shimmerCard(sizeConfig.deviceWidth,
                                        sizeConfig.deviceHeight);
                              }),
                        ),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 46 * sizeConfig.deviceHeight,
                  ),
                  TabBar(
                    onTap: ((value) {
                      switch (value) {
                        case 0:
                          homeController.getNowPlaying();
                          break;
                        case 1:
                          homeController.getUpcoming();
                          break;
                        case 2:
                          homeController.getPopluar();
                          break;
                        case 3:
                          homeController.getTopRatedShows();
                          break;
                      }
                    }),
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xff3A3F47).withOpacity(1),
                    controller: tabController,
                    tabs: homeController.tabNames.map((e) {
                      return Tab(
                        height: 52,
                        text: e.toString(),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: TabBarView(controller: tabController, children: [
                      GridView.builder(
                          itemCount: homeController.nowPlaying.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            var imgurl = homeController.nowPlaying[index].image;
                            return tvShowImage(sizeConfig.deviceWidth,
                                sizeConfig.deviceHeight, imgurl.url);
                          })),
                      GridView.builder(
                          itemCount: homeController.upcoming.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            var imgurl = homeController.upcoming[index].image;
                            return tvShowImage(sizeConfig.deviceWidth,
                                sizeConfig.deviceHeight, imgurl.url);
                          })),
                      GridView.builder(
                          itemCount: homeController.popular.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            var imgurl = homeController.popular[index].image;
                            return tvShowImage(sizeConfig.deviceWidth,
                                sizeConfig.deviceHeight, imgurl.url);
                          })),
                      GridView.builder(
                          itemCount: homeController.topRatedShows.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: ((context, index) {
                            var imgurl =
                                homeController.topRatedShows[index].image;
                            return tvShowImage(sizeConfig.deviceWidth,
                                sizeConfig.deviceHeight, imgurl.url);
                          })),
                    ]),
                  )
                ],
              )
            : errorWidget(sizeConfig.deviceWidth, sizeConfig.deviceHeight);
      }),
    );
  }
}
