import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

class DealsEntity extends Equatable{
  final String? title;
  final String? banner;
  final List<String>? buyXGetYFree;
  final List<String>? buyXYGetZFree;
  final List<String>? mainProducts;
  final bool? isArabic;

  const DealsEntity({this.title,this.banner, this.buyXGetYFree, this.buyXYGetZFree, this.mainProducts, this.isArabic});
  
  @override
  List<Object?> get props => [title];

  bool checkLangInsideDeal(){
    return ((Util.getLang()=="ar"&&isArabic==true) || (Util.getLang()=="en_US"&&isArabic==false));
  }
}


class BuyXYGetZ{
  final List<ProductsEntity>? list; 
  final String? banner;
  const BuyXYGetZ({required this.banner,required this.list});
}