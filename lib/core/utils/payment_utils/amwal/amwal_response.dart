class AmWalResponse{
  final bool success;
  final bool? canceled;
  final bool? failed;
  final String msg;
  final String? transactionId;
  AmWalResponse({required this.msg,required this.success,this.canceled,this.failed,this.transactionId});
}