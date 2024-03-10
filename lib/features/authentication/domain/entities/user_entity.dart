import 'package:equatable/equatable.dart';

class UserService extends Equatable {
  final int? userId;
  final String? userLogin;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? image;
  final String? area;
  final String? address;
  final String? countryCode;
  final String? cityID;
  final String? fullLocationDetails;
  final double? lat;
  final double? long;
  final bool? status;

  final String? lastNotificationUnread;

  /// if false then user is offline
  final bool? isApproved;



  const UserService({
    this.userId,
    this.userLogin,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.image,
    this.area,
    this.cityID,
    this.address,
    this.countryCode,
    this.status,
    this.isApproved,
    this.fullLocationDetails,
    this.lat,
    this.long,
    this.lastNotificationUnread,
  });

  @override
  List<Object?> get props => [userId];
}

