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
  final bool isTrack;
  const OrderCardDetails({Key? key,this.enableTracking = false,required this.item,this.isTrack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: isTrack ? 0 : 5,
        color: DMUtil.getWC(),
        shape: RoundedRectangleBorder(
            side:isTrack? BorderSide.none : const BorderSide(width: 1,color: Colors.white),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
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
                    fontWeight: FontWeight.w600,
                    fontSize: AppStyle.small.sp+2,
                  ),
                  CustomText(
                    text: "${translate("order.date")} ${Util.formatToDayFullMonthYear(DateTime.parse(item.date.toString()))}",
                    color: DMUtil.getD2C(),
                    fontSize: AppStyle.small.sp+1,
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              if(item.items!=null && item.items!.isNotEmpty)
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx,index){
                  var it = item.items![index];
                  var qty = it.qty;
                  var product = ProductsEntity(
                      priceWithoutTax: it.price,
                      title: it.title, sku: "",catTitle: "", desc: "", id: it.id,
                      imgPath: "", price: it.price, discount: 0, discountRate: 0, stockStatus: true,
                      quantity: int.parse(it.qty), categoryList: const [], catID: 0, commentCount: 2);
                  int ind = ProductsBloc.get(context).storedProductsList.indexWhere((element) => element.id==product.id );
                  if(ind!=-1) product = ProductsBloc.get(context).storedProductsList[ind];
                  return ProductCardFewData(item: product,qty: qty.toString(),isTrack: isTrack,);
                },
                separatorBuilder: (ctx,index) => const SizedBox(height: 5,),
                itemCount: item.items!.length,
              ),

              if(enableTracking)...[
                const SizedBox(height: 10,),
                CustomButton(
                  height: 28.h,
                  width: 110.w,
                  circular: 14,
                  widget: CustomText(
                    text: translate("order.track_location"),
                    color: Colors.white,
                    fontSize: AppStyle.small.sp+2,
                  ),
                  color: DMUtil.getRED(),
                  onPressed: ()=>  Util.pushPage(OrderTrackingScreen(item: item,), context),
                ),
                const SizedBox(height: 5,),
              ],

            ],
          ),
        )
    );
  }
}
