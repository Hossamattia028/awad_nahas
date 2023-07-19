import 'dart:convert';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/wishlist/domain/entities/favourite.dart';

class FavouriteModel extends FavouriteEntity {
  const FavouriteModel(
      {required super.id,
      required super.serviceID,
      required super.packageID,
      required super.favImage,
      required super.favTitle,
      });


  static List<FavouriteModel> favouriteListFromJson(String str) =>
      List<FavouriteModel>.from(
          json.decode(str).map((x) => FavouriteModel.fromJson(x)));

  static FavouriteModel fromJson(Map<String, dynamic> jsonObject) {
    return FavouriteModel(
      id: jsonObject['id'],
      serviceID: jsonObject['service_id'],
      packageID: jsonObject['package_id'] ,
      favTitle: jsonObject['title'] ,
      favImage: "${ApiUrl.STORAGE_URL}${jsonObject['image']}",
    );
  }

}
