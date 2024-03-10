import 'package:equatable/equatable.dart';

class NotificationsEntity extends Equatable{
  final int id;
  final int userID;
  final String title;
  final String content;
  final String type;
  final String date;
  final int orderID;
  final int orderWpID;

  const NotificationsEntity({required this.id,required this.userID,required this.title,required this.content,required this.type,required this.orderID,required this.orderWpID,required this.date});

  @override
  List<Object?> get props => [id, userID];
}