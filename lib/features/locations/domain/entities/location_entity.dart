import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable{
  final int id;
  final String address;
  final String city;
  final String country;
  final String phone;
  final String type;
  final double lat;
  final double long;
  const LocationEntity({required this.address,required this.city,required this.country,required this.phone,required this.id,required this.type,required this.long,required this.lat});

  @override
  List<Object?> get props => [id, address,city,phone];
}