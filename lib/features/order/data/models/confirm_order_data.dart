import 'dart:io';

class ConfirmOrderData{
  File? confirmedFile;
  bool? productReceived;
  bool? productDelivered;

  ConfirmOrderData({this.confirmedFile,this.productDelivered,this.productReceived});
}