import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable{
  final int id;
  final String iconPath;
  final String imgPath;
  final String title;
  final bool isArabic;

  const CategoriesEntity({required this.title,required this.id,required this.imgPath,required this.iconPath,required this.isArabic});

  @override
  // TODO: implement props
  List<Object?> get props => [id,title];


}