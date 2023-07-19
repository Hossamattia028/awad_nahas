import 'dart:convert';

class PhotoModel {
  final int id;
  final bool status;
  final String imgUrl;
  const PhotoModel({required this.status,required this.id,required this.imgUrl});

  static PhotoModel fromJson(Map<String,dynamic> json){
    return PhotoModel(
      id: json['ID'],
      status: json['post_status']=="publish",
      imgUrl: json['guid'],
    );
  }

  static List<PhotoModel> listModelFromJson(String str) =>
      List<PhotoModel>.from(
          json.decode(str).map((x) => PhotoModel.fromJson(x)));


}