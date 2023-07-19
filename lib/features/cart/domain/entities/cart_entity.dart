import 'package:equatable/equatable.dart';
import 'package:awad_nahas/features/cart/data/models/cart_model.dart';

class CartEntity extends Equatable{
  final int id;
  final int? sessionID;
  final String? sessionKey;
  final List<CartModelProducts> sessionValue;
  final double total;

  const CartEntity({required this.id,required this.sessionKey,required this.sessionID,required this.sessionValue,required this.total});

  @override
  // TODO: implement props
  List<Object?> get props => [id,];
}