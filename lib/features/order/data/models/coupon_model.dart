class CouponModel {
  String? code;
  bool?  isPercent;
  int?  amount;
  String? sessionKey;
  int? sessionID;
  double? total;

  CouponModel({this.code, this.isPercent,this.amount,this.sessionKey,this.sessionID,this.total});

}


class ResCouponModel {
  final CouponModel couponModel;
  final String msg;
  final bool status;

  const ResCouponModel({required this.couponModel, required this.msg,required this.status,});

}