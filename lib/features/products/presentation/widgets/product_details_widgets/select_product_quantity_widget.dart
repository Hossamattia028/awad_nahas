import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';

class SelectProductQuantityWidget extends StatelessWidget {
  final ProductsEntity item;
  const SelectProductQuantityWidget({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            InkWell(
              onTap: ()=> CartBloc.get(context).add(UpdateCartProductEvent(product: item, isAdd: true,context: context)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                height: 20.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: kText1),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15))
                ),
                child: Icon(Icons.add,color: Colors.black,size: 13.w,),
              ),
            ),
            SizedBox(width: 26.w,),
            InkWell(
              onTap: ()=> CartBloc.get(context).add(UpdateCartProductEvent(product: item, isAdd: false,context: context)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                height: 20.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: kText1),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))
                ),
                child: Icon(Icons.remove,color: Colors.black,size: 13.w,),
              ),
            ),
          ],
        ),
        BlocBuilder<CartBloc,CartState>(
          builder: (ctx,state){
            var list = CartBloc.get(ctx).cartList;
            int index = list.indexWhere((element) => item.id==element.id);
            String qty = "1";
            if(index!=-1)qty=list[index].quantity.toString();
            return Container(
              height: 30.h,
              width: 29.w,
              margin: EdgeInsets.symmetric(horizontal: 26.w,),
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(Radius.circular(3)),
                color: kSecondPrimary,
              ),
              child: CustomText(
                text: qty,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: AppStyle.average.sp,
              ),
            );
          },
        ),

      ],
    );
  }
}
