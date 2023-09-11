import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/select_product_quantity_widget.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/empty_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';

class CartListWidget extends StatelessWidget {
  const CartListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        var list = bloc.cartList;
        if(list.isEmpty)return const EmptyCartWidget();
        return SizedBox(
          height: 300.h,
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 10,top: 5),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx,index){
              ProductsEntity? item ;
              int ind = ProductsBloc.get(context).productsList.indexWhere((element) => list[index].id==element.id);
              if(ind==-1){
                ind = ProductsBloc.get(context).storedProductsList.indexWhere((element) => list[index].imgPath==element.imgPath);
                if(ind==-1)return const SizedBox.shrink();
                item = ProductsBloc.get(context).storedProductsList[ind];
              }else{
                item = ProductsBloc.get(context).productsList[ind];
              }
              return Container(
                height: 125.h,
                padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  color: DMUtil.getWC(),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        color: DMUtil.getWC(),
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(width: 1,color: Colors.white)
                        ),
                        child: ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain,width: 60.w,)),
                    Expanded(
                      child: Card(
                        elevation: 3,
                        color: DMUtil.getWC(),
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(width: 1,color: Colors.white)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: 200.w,
                                  height: 20.h,
                                  child: SingleChildScrollView(
                                    child: CustomText(
                                      text: item.title,
                                      color: DMUtil.getD2C(),
                                      fontWeight: FontWeight.w700,
                                      fontSize: AppStyle.average.sp-3,
                                      maxLine: 5,
                                      isEllipsis: true,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectProductQuantityWidget(item: item,),
                                  ProductPriceWidget(productModel: item),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              );
            },
            separatorBuilder: (ctx,index)=> const SizedBox(height: 1,),
            itemCount: list.length,
          ),
        );
      },
    );
  }
}
