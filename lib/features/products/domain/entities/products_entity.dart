import 'package:awad_nahas/features/products/data/models/product_attributes.dart';
import 'package:awad_nahas/features/products/data/models/product_comments.dart';
import 'package:awad_nahas/features/products/data/models/product_small_model.dart';
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
  final int catID;
  final int? brandID;
  final List<CategoriesEntity> categoryList;
  final List<ProductComments>? reviewsList;
  final String? date;
  final String? averageRate;
  final ProductAttributes? attributes;

  const ProductsEntity({required this.title,required this.catTitle,
    required this.desc,required this.id,required this.imgPath,
    required this.price,required this.discount,
    required this.discountRate,
    required this.stockStatus,required this.quantity,
    required this.categoryList,
    required this.catID,
    this.brandID,
    this.isArabic,
    this.reviewsList,
    required this.commentCount,
    this.date,
    this.averageRate,
    this.attributes,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id,title];


}

