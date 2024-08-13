// import 'package:amwal_pay/amwal_pay.dart';
// import 'package:awad_nahas/core/utils/payment_utils/amwal/amwal_response.dart';
// import 'package:awad_nahas/core/utils/payment_utils/amwal/constants.dart';
// import 'package:awad_nahas/core/utils/small_fun.dart';
// import 'package:awad_nahas/core/utils/sms_api.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_translate/flutter_translate.dart';

// class AmWalPlugin {
//   //4464040000000007
//   // 02/25
//   // 123
//   static AmwalPay? amWalPay;

//   static AmwalPay? initialize({String? orderID,String? phone}){
//     orderID = orderID ?? SmsApi.getRandom().toString();
//     phone = phone.toString().trim()==""?"null":phone.toString().trim();
//     if(phone=="null"){
//       amWalPay = AmwalPayBuilder(AmWalConstants.merchantIdentifierSandBox)
//               .countryCode('+966').refId(orderID).orderId(orderID)
//               .language(Util.getLang()=="ar"?AmwalPayLanguage.Arabic:AmwalPayLanguage.English)
//               .build();
//       return amWalPay;
//     }
//     phone = phone.startsWith("0")?"+966$phone":"+9660$phone";
//     amWalPay = AmwalPayBuilder(AmWalConstants.merchantIdentifierSandBox)
//         .countryCode('+966').refId(orderID).orderId(orderID)
//         .language(Util.getLang()=="ar"?AmwalPayLanguage.Arabic:AmwalPayLanguage.English)
//         .phoneNumber(phone)
//         .build();
//     return amWalPay;
//   }

//   static Future<AmWalResponse> pay(double amount,String orderID)async{
//     try{
//       amWalPay = initialize(orderID: orderID, phone: Util.getMobile());
//       TransactionStatus? paymentResult = await amWalPay!.start(amount);
//       switch (paymentResult.type) {
//         case TransactionStatusType.success:
//           debugPrint('Transaction Success with ID: ${(paymentResult as TransactionSuccess).transactionId}');
//           return AmWalResponse(msg: "", success: true,transactionId: paymentResult.transactionId);
//         case TransactionStatusType.failure:
//           debugPrint('Transaction Failed. ${(paymentResult as TransactionFailure)}, Message: ${paymentResult.message}');
//           return AmWalResponse(msg: "", success: false,transactionId: paymentResult.message.toString());
//         case TransactionStatusType.cancel:
//           debugPrint('Transaction Cancelled');
//           return AmWalResponse(msg: translate("toast.wrong_payment"), success: false,canceled: true);
//       }
//     }catch(e){
//       debugPrint("AmWalPlugin payError: $e");
//       return AmWalResponse(msg: translate("toast.wrong_payment"), success: false);
//     }
//   }


// }


