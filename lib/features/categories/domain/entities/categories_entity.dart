import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable{
  final int id;
  final String iconPath;
  final String imgPath;
  final String title;
  final bool isArabic;
  final String parentID;
  final int productsCount;



  const CategoriesEntity({required this.title,required this.id,required this.imgPath,required this.iconPath,required this.isArabic,required this.parentID,required this.productsCount});

  @override
  // TODO: implement props
  List<Object?> get props => [id,title];


}