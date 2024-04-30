import 'package:awad_nahas/features/products/domain/entities/deals_entity.dart';

class DealsModel extends DealsEntity{
  const DealsModel({super.title, super.buyXGetYFree, super.mainProducts, super.isArabic});

  static DealsModel fromJson(Map<String, dynamic> json) {
    return DealsModel(
      title: json['title'],
      buyXGetYFree: json['buy_x_get_y_free'].cast<String>(),
      mainProducts: json['main_products'].cast<String>(),
      isArabic: json['is_arabic']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['buy_x_get_y_free'] = buyXGetYFree;
    data['main_products'] = mainProducts;
    data['is_arabic'] = isArabic;
    return data;
  }
}
