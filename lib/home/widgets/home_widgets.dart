import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerCard(double w, double h) {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade600,
      highlightColor: Colors.grey.shade200,
      child: Container(
        margin: EdgeInsets.only(right: 30 * w, top: 18 * h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        width: 114 * w,
        height: 210 * h,
      ));
}
