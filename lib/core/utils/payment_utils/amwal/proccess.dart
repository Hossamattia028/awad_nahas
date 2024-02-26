import 'package:amwal_pay/amwal_pay.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/amwal_response.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/constants.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/core/utils/sms_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AmWalPlugin {
  static AmwalPay? amWalPay;


  static AmwalPay? initialize({String? orderID,String phone = "502441695"}){
    orderID = orderID ?? SmsApi.getRandom().toString();
    phone = phone.toString().trim()==""?"502441695":phone.trim();
    phone = phone.startsWith("0")?"+966$phone":"+9660$phone";
    amWalPay = AmwalPayBuilder(AmWalConstants.merchantIdentifierSandBox)
        .countryCode('+966').refId(orderID).orderId(orderID)
        .language(Util.getLang()=="ar"?AmwalPayLanguage.Arabic:AmwalPayLanguage.English)
        .phoneNumber(phone)
        .build();
    return amWalPay;
  }


  static Future<AmWalResponse> pay(double amount,String orderID)async{
    try{
      amWalPay = initialize(orderID: orderID, phone: Util.getMobile());
      String? paymentResult = await amWalPay!.start(amount);
      debugPrint("AmWalPlugin pay ${paymentResult.toString()}");
      if(paymentResult.toString().toLowerCase().contains("canceled")){
        return AmWalResponse(msg: translate("toast.wrong_payment"), success: false,canceled: true);
      }else{
        return AmWalResponse(msg: "", success: true,transactionId: paymentResult.toString());
      }
    }catch(e){
      debugPrint("AmWalPlugin payError: $e");
      return AmWalResponse(msg: translate("toast.wrong_payment"), success: false);
    }
  }


}


