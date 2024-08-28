// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

List<CompanyModel> companyModelFromJson(String str) => List<CompanyModel>.from(json.decode(str).map((x) => CompanyModel.fromJson(x)));

String companyModelToJson(List<CompanyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompanyModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  CompanyModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    albumId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );

  Map<String, dynamic> toJson() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };
}
