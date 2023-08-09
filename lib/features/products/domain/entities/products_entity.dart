import 'package:equatable/equatable.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';

class ProductsEntity extends Equatable{
  final int id;
  final String imgPath;
  final String title;
  final String catTitle;
  final String desc;
  final double price;
  final double discount;
  final double discountRate;
  final bool stockStatus;
  final int quantity;
  final int commentCount;
  final bool? isArabic;
  final List<CategoriesEntity> categoryList;


  const ProductsEntity({required this.title,required this.catTitle,
    required this.desc,required this.id,required this.imgPath,
    required this.price,required this.discount,
    required this.discountRate,
    required this.stockStatus,required this.quantity,
    required this.categoryList,
    this.isArabic,
    required this.commentCount
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,title];


}