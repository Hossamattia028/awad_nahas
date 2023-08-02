import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
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
              child: Card(
                color: DMUtil.getWC(),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 1,color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.add,color:  DMUtil.getDC(),size: 16.w,),
                ),
              ),
            ),
            SizedBox(width: 26.w,),
            InkWell(
              onTap: ()=> CartBloc.get(context).add(UpdateCartProductEvent(product: item, isAdd: false,context: context)),
              child: Card(
                color: DMUtil.getWC(),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(width: 1,color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.remove,color:  DMUtil.getDC(),size: 16.w,),
                ),
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
            return CustomText(
              text: qty,
              color: DMUtil.getDC(),
              fontWeight: FontWeight.w700,
              fontSize: AppStyle.average.sp,
            );
          },
        ),

      ],
    );
  }
}
