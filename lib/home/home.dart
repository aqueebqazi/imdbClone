import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb_clone/home/controller/home_controller.dart';
import 'package:imdb_clone/common%20widgets/common_widget.dart';
import 'package:imdb_clone/home/widgets/home_widgets.dart';
import 'package:imdb_clone/theme/global_styles.dart';
import 'package:imdb_clone/theme/themes.dart';
import 'package:imdb_clone/core/api/utils/size_config.dart';

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
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    homeController.getShowID();
    homeController.isNowPlayingLoading = true;

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: appTheme.primaryColor,
      body: GetBuilder<HomeController>(builder: (homeControllerInstance) {
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
                    return homeController.isloading == false
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 34 * sizeConfig.deviceWidth),
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
                                      return Stack(
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
                                      );
                                    }),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 210 * sizeConfig.deviceHeight,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return shimmerCard(sizeConfig.deviceWidth,
                                      sizeConfig.deviceHeight, 30, 10);
                                }),
                          );
                  }),
                  SizedBox(
                    height: 46 * sizeConfig.deviceHeight,
                  ),
                  TabBar(
                    onTap: ((value) {
                      switch (value) {
                        case 0:
                          if (homeControllerInstance.nowPlaying.isEmpty) {
                            homeController.getNowPlaying();
                          }
                          break;
                        case 1:
                          if (homeControllerInstance.upcoming.isEmpty) {
                            homeController.getUpcoming();
                          }
                          break;
                        case 2:
                          if (homeControllerInstance.popular.isEmpty) {
                            homeController.getPopluar();
                            log("popular called");
                          }
                          break;
                        case 3:
                          if (homeControllerInstance.topRatedShows.isEmpty) {
                            homeController.getTopRatedShows();
                          }
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
                  Padding(
                    padding: EdgeInsets.only(left: 22 * sizeConfig.deviceWidth),
                    child: SizedBox(
                      width: 330 * sizeConfig.deviceWidth,
                      height: 300 * sizeConfig.deviceHeight,
                      child: TabBarView(controller: tabController, children: [
                        //nowPlayingGridView

                        GridView.builder(
                            itemCount: homeController.nowPlaying.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: ((context, index) {
                              var imgurl =
                                  homeController.nowPlaying[index].image;
                              return homeController.isNowPlayingLoading == false
                                  ? tvShowImage(sizeConfig.deviceWidth,
                                      sizeConfig.deviceHeight, imgurl.url)
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    );
                            })),

                        //Upcoming GridView
                        GetBuilder<HomeController>(builder: (context) {
                          return GridView.builder(
                              itemCount: homeController.upcoming.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, crossAxisSpacing: 2),
                              itemBuilder: ((context, index) {
                                var imgurl =
                                    homeController.upcoming[index].image;
                                return homeController.isUpcomingLoading == false
                                    ? tvShowImage(sizeConfig.deviceWidth,
                                        sizeConfig.deviceHeight, imgurl.url)
                                    : shimmerCard(sizeConfig.deviceWidth,
                                        sizeConfig.deviceHeight, 10, 10);
                              }));
                        }),

                        //Popular
                        GridView.builder(
                            itemCount: homeController.popular.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: ((context, index) {
                              var imgurl = homeController.popular[index].image;
                              return homeController.isPopularLoading == false
                                  ? tvShowImage(sizeConfig.deviceWidth,
                                      sizeConfig.deviceHeight, imgurl.url)
                                  : shimmerCard(sizeConfig.deviceWidth,
                                      sizeConfig.deviceHeight, 10, 10);
                            })),
                        //TopRatedShows
                        GridView.builder(
                            itemCount: homeController.topRatedShows.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: ((context, index) {
                              var imgurl =
                                  homeController.topRatedShows[index].image;
                              return homeController.isTopRatedLoading == false
                                  ? tvShowImage(sizeConfig.deviceWidth,
                                      sizeConfig.deviceHeight, imgurl.url)
                                  : shimmerCard(sizeConfig.deviceWidth,
                                      sizeConfig.deviceHeight, 10, 10);
                            })),
                      ]),
                    ),
                  )
                ],
              )
            : errorWidget(sizeConfig.deviceWidth, sizeConfig.deviceHeight);
      }),
    );
  }
}
