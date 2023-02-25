import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Image {
  Image({
    required this.height,
    required this.id,
    required this.url,
    required this.width,
  });

  int height;
  String id;
  String url;
  int width;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        height: json["height"] ?? 0,
        id: json["id"] ?? "",
        url: json["url"] ?? "",
        width: json["width"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "id": id,
        "url": url,
        "width": width,
      };
}

class TvShowApi {
  TvShowApi({
    required this.body,
    required this.head,
    required this.id,
    required this.image,
    required this.link,
    required this.publishDateTime,
    required this.source,
  });

  String body;
  String head;
  String id;
  Image image;
  String link;
  DateTime publishDateTime;
  Source source;

  factory TvShowApi.fromJson(Map<String, dynamic> json) => TvShowApi(
        body: json["body"],
        head: json["head"],
        id: json["id"],
        image: Image.fromJson(json["image"]),
        link: json["link"],
        publishDateTime: DateTime.parse(json["publishDateTime"]),
        source: Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "head": head,
        "id": id,
        "image": image.toJson(),
        "link": link,
        "publishDateTime": publishDateTime.toIso8601String(),
        "source": source.toJson(),
      };
}

class Source {
  Source({
    required this.id,
    required this.label,
    required this.link,
  });

  String id;
  String label;
  String link;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        label: json["label"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "link": link,
      };
}
