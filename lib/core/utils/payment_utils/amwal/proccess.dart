import 'package:amwal_pay/amwal_pay.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/amwal_response.dart';
import 'package:awad_nahas/core/utils/payment_utils/amwal/constants.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AmWalPlugin {
  static AmwalPay? amWalPay;


  static initialize(){
    amWalPay = AmwalPayBuilder(AmWalConstants.merchantIdentifierProduction)
        .countryCode('+966').refId("1230").orderId("1230").language(Util.getLang()=="ar"?AmwalPayLanguage.Arabic:AmwalPayLanguage.English)
        .build();
  }


  static Future<AmWalResponse> pay(double amount)async{
    try{
      String? paymentResult = await amWalPay!.start(1);
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


