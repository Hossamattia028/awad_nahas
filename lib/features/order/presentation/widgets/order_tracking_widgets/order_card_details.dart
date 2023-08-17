import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_tracking.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_card_with_few_data.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';



class OrderCardDetails extends StatelessWidget {
  final bool enableTracking;
  final Orders item;
  const OrderCardDetails({Key? key,this.enableTracking = false,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: DMUtil.getWC(),
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1,color: Colors.white),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "#${item.orderId}",
                    color: DMUtil.getD2C(),
                    fontSize: AppStyle.small.sp,
                  ),
                  CustomText(
                    text: "${translate("order.date")} ${Util.formatToDayFullMonthYear(DateTime.parse(item.date.toString()))}",
                    color: DMUtil.getD2C(),
                    fontSize: AppStyle.small.sp,
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              if(item.items!=null && item.items!.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx,index){
                  var it = item.items![index];
                  var product = ProductsEntity(title: it.title, catTitle: "", desc: "", id: it.id, imgPath: "", price: it.price, discount: 0, discountRate: 0, stockStatus: true, quantity: 0, categoryList: [], catID: 0, commentCount: 2);
                  int ind = ProductsBloc.get(context).productsList.indexWhere((element) => element.id==product.id );
                  if(ind!=-1) product = ProductsBloc.get(context).productsList[ind];
                  return ProductCardFewData(item: product);
                },
                separatorBuilder: (ctx,index) => const SizedBox(height: 5,),
                itemCount: item.items!.length,
              ),

              if(enableTracking)...[
                const SizedBox(height: 10,),
                CustomButton(
                  height: 30.h,
                  width: 105.w,
                  circular: 14,
                  widget: CustomText(
                    text: translate("order.track_location"),
                    color: Colors.white,
                    fontSize: AppStyle.small.sp+2,
                  ),
                  color: DMUtil.getRED(),
                  onPressed: ()=>  Util.pushPage(OrderTrackingScreen(item: item,), context),
                ),
              ],

            ],
          ),
        )
    );
  }
}
