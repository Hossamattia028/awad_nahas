import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/order/presentation/widgets/thanks_order_dialog_widget.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/add_comments.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/account/presentation/widgets/delete_account.dart';
import 'package:awad_nahas/features/account/presentation/widgets/sign_out.dart';
import 'package:awad_nahas/features/order/presentation/widgets/sure_to_cancel_order.dart';
import 'package:awad_nahas/features/order/presentation/widgets/shipping_address.dart';
import 'package:awad_nahas/features/shared_widgets/sure_to_delete_widget.dart';
import 'package:awad_nahas/features/shared_widgets/sure_to_submit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialogs {
  static cancelOrderDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          backgroundColor: Colors.transparent,
          child: CancelOrderWidget(),
        );
      },
    );
  }


  static signOut(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: SignOut());
        });
  }


  static deleteAccount(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: DeleteAccount());
        });
  }

  static shippingAddress(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: ShippingAddress());
        });
  }

  static sureToSubmit(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: SureToSubmitWidget());
        });
  }

  static sureToDelete(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: SureToDeleteWidget());
        });
  }


  static thanksOrder(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return const Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: ThanksOrderWidget());
        });
  }



  static viewImage(BuildContext context,String img) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return  Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: ()=> Navigator.of(context).pop(),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child:  Icon(Icons.close,color: kPrimary,),
                      ),
                    ),
                    Image.network(img,width: double.infinity,height: 500.h,),
                  ],
                )
              ));
        });
  }

  static addComment(BuildContext context,ProductsEntity item) async {
    return await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return  Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              backgroundColor: Colors.transparent,
              child: AddCommentsWidget(item:item),
          );
        });
  }




}
