

import 'dart:convert';

import 'package:awad_nahas/features/categories/data/models/photo_model.dart';
import 'package:awad_nahas/features/categories/domain/entities/slider_entity.dart';

class SliderModel extends SliderEntity{
  const SliderModel({required super.title,required super.images,required super.id});

  static SliderModel fromJson(Map<String, dynamic> jsonObject) {
    return SliderModel(
      id: jsonObject['ID']??"",
      title: jsonObject['post_title']??"",
      images: PhotoModel.listModelFromJson(jsonEncode(jsonObject['photo'])),
    );
  }
}


