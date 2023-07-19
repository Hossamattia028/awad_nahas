import 'package:awad_nahas/features/categories/data/models/photo_model.dart';
import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable{
  final int id;
  final String title;
  final List<PhotoModel> images;
  const SliderEntity({required this.title,required this.images,required this.id});

  @override
  List<Object?> get props => [id, title,images];
}