import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable{
  final int id;
  final String imgPath;
  final String title;

  const CategoriesEntity({required this.title,required this.id,required this.imgPath,});

  @override
  // TODO: implement props
  List<Object?> get props => [id,title];


}