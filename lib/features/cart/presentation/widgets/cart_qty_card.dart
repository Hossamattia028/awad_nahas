import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/qt_widget.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class CartQtyCard extends StatelessWidget {
  final ProductsEntity item;
  const CartQtyCard({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        int currentCount = bloc.currentCount;
        return Stack(
          children: [
            if(bloc.showCountWidget && item.id == bloc.currentCartProductModify)...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: translate("products.quantity"),
                        color: DMUtil.getD2C(),
                        fontSize: AppStyle.small.sp ,
                      ),
                      InkWell(
                        onTap: ()=> bloc.add(const UpdateCountWidgetEvent()),
                        child: Icon(Icons.close,color: DMUtil.getD2C().withOpacity(0.8),size: AppStyle.large.w,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        QtyCard(val: 1, selected: currentCount==1,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 2, selected: currentCount==2,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 3, selected: currentCount==3,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 4, selected: currentCount==4,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 5, selected: currentCount==5,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 6, selected: currentCount==6,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 7, selected: currentCount==7,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 8, selected: currentCount==8,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 9, selected: currentCount==9,item: item,isCart: true,bloc: bloc,),
                        QtyCard(val: 10, selected: currentCount==10,item: item,isCart: true,bloc: bloc,),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ],
        );
      },
    );
  }
}


class IconQtyCart extends StatelessWidget {
  final ProductsEntity item;
  const IconQtyCart({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> CartBloc.get(context).add(UpdateCountWidgetEvent(productId: item.id)),
      child: Container(
          height: 30.h,
          width: 46.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(width: 0,color: DMUtil.getD2C().withOpacity(0.5)),
            color: DMUtil.getWC(),
          ),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: item.quantity.toString(),
                color: DMUtil.getD2C().withOpacity(0.8),
                fontSize: AppStyle.small.sp,
                fontWeight: FontWeight.bold,
              ),
              Icon(Icons.keyboard_arrow_down_outlined,color: DMUtil.getD2C().withOpacity(0.6),size: 16.w,)
            ],
          ),
      ),
    );
  }
}
