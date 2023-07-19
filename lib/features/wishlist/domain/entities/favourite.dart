import 'package:equatable/equatable.dart';

class FavouriteEntity extends Equatable{
  final int id;
  final int? serviceID;
  final int? packageID;
  final String favTitle;
  final String favImage;

  const FavouriteEntity({required this.id,required this.serviceID,required this.packageID,required this.favImage,required this.favTitle});

  @override
  // TODO: implement props
  List<Object?> get props => [id,favTitle,favImage];
}