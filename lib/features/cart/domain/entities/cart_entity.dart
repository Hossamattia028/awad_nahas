import 'package:awad_nahas/features/cart/data/models/cart_serilize_data.dart';
import 'package:equatable/equatable.dart';
import 'package:awad_nahas/features/cart/data/models/cart_model.dart';

class CartEntity extends Equatable{
  final int id;
  final int? sessionID;
  final List<CartModelProducts> sessionValue;
  final double total;
  final CartSerialize? cartSerialize;

  const CartEntity({required this.id,required this.sessionID,required this.sessionValue,required this.total,this.cartSerialize});

  @override
  // TODO: implement props
  List<Object?> get props => [id,];
}