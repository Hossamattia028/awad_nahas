import 'package:awad_nahas/features/products/domain/entities/deals_entity.dart';

class DealsModel extends DealsEntity{
  const DealsModel({super.title, super.banner ,super.buyXGetYFree, super.buyXYGetZFree,super.mainProducts, super.isArabic});

  static DealsModel fromJson(Map<String, dynamic> json) {
    return DealsModel(
      title: json['title'],
      banner: json['banner'] ?? "",
      buyXGetYFree: json['buy_x_get_y_free']==null? [] : json['buy_x_get_y_free'].cast<String>(),
      buyXYGetZFree: json['buy_x_and_y_get_z_free']==null? [] : json['buy_x_and_y_get_z_free'].cast<String>(),
      mainProducts: json['main_products']==null? [] : json['main_products'].cast<String>(),
      isArabic: json['is_arabic']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['banner'] = banner;
    data['buy_x_get_y_free'] = buyXGetYFree;
    data['buy_x_and_y_get_z_free'] = buyXYGetZFree;
    data['main_products'] = mainProducts;
    data['is_arabic'] = isArabic;
    return data;
  }
}
