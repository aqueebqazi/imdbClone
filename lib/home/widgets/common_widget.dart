import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb_clone/home/controller/home_controller.dart';
import 'package:imdb_clone/home/widgets/home_widgets.dart';

Widget errorWidget(double w, double h) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/svg/error.svg",
          width: 200 * w,
          height: 200 * h,
        ),
        Text(
          "Something Went wrong",
          style: GoogleFonts.poppins(
              fontSize: 16 * w,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        )
      ],
    ),
  );
}

Widget tvShowImage(double w, double h, String imgurl) {
  return Padding(
    padding: EdgeInsets.only(top: 18 * h, right: 30 * w),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl: imgurl,
        width: 144 * w,
        height: 210 * h,
        fit: BoxFit.fitHeight,
      ),
    ),
  );
}
