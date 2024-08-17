import 'dart:io';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/tabby/ui/tabby_check_out_widget.dart';
import 'package:awad_nahas/core/utils/payment_utils/tabby/ui/tabby_small_widget.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_widgets.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/back_to_top.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/brand_products.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_details_data_taps.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_main_details.dart';
import 'package:awad_nahas/features/root_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/related_products.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';



class ProductDetailPage extends StatefulWidget {
  final ProductsEntity item;
  const ProductDetailPage({super.key,required this.item});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String catListString = "";
  late ProductsBloc productsBloc;
  double currentPrice = 0.0;
  ScrollController controller = ScrollController();
  bool enableBTop = false;

  @override
  void didChangeDependencies() {
    LocationsBloc.get(context).checkLocation(context);
    currentPrice = widget.item.price!=widget.item.discount&&widget.item.discount!=0?widget.item.discount:widget.item.price;
    if(widget.item.categoryList.isNotEmpty){
      for(var i in widget.item.categoryList){
        catListString += i.title;
      }
    }
    productsBloc = ProductsBloc.get(context);
    CartBloc.get(context).add(const UpdateCountBeforeInsertInCart(value: 1));
    productsBloc..add(UpdateCurrentProduct(item: widget.item))..add(const ShowFullContentEvent(val: false))..add(const ChangeWidgetSizeEvent(height: 250,index: 0));
    controller.addListener(() {
      if(controller.position.pixels>500.w){
        if(enableBTop!=true){
          setState(() {
            enableBTop = true;
          });
        }
      }else if(controller.position.pixels<100.w){
        if(enableBTop!=false){
          setState(() {
            enableBTop = false;
          });
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Scaffold(
          backgroundColor: DMUtil.getBackGround(),
          appBar: GlobalAppBar(
            backGroundColor: DMUtil.getRED(),
            title: widget.item.title,
            textColor: Colors.white,
            leadingIcon: const BackArrowButton(color: Colors.white,),
          ),
          body: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                ProductMainDetails(item: widget.item),

                if(Util.checkUser() && currentPrice<=CartBloc.get(context).tamaraMax)...[
                  const SizedBox(height: 15,),
                  TamaraSmallProductWidget(price: currentPrice),
                ],
                if(Util.checkUser() && currentPrice<=CartBloc.get(context).tabbyMax)...[
                   TabbySmallProductWidget(price: currentPrice),
                ],
               

                const SizedBox(height: 20,),
                ProductDetailsDataRow(item: widget.item),


                if(widget.item.brandID!=null)...[
                  const SizedBox(height: 25,),
                  BlocBuilder<CategoriesBloc,CategoriesState>(
                    builder: (ctx,state){
                      var bloc = CategoriesBloc.get(ctx);
                      int index = bloc.brandsList.indexWhere((element) => element.id==widget.item.brandID);
                      if(index == -1) return const SizedBox.shrink();
                      var brand = bloc.brandsList[index];
                      return BrandProductsWidget(item:  widget.item,brandTitle: brand.title,);
                    },
                  ),
                ],

                RelatedProductsWidget(item:  widget.item,),
                SizedBox(height: 170.h,),
              ],
            ),
          ),
        ),
        if(enableBTop==true)
          Material(
            color: Colors.transparent,
            child: BlocBuilder<CartBloc,CartState>(
              builder: (ctx,state){
                var bloc =  CartBloc.get(ctx);
                double val = 125.h + 22.w;
                if(bloc.showCountWidget)val += 44.w;
                return InkWell(
                  onTap: ()=> controller.animateTo(10, duration: const Duration(milliseconds: 1000), curve: Curves.linear),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: val,),
                    child: const BackToTopWidget(),
                  ),
                );
              },
            )
          ),
        Material(
          color: Colors.transparent,
          child: BlocBuilder<CartBloc,CartState>(
            builder: (ctx,state){
              var bloc =  CartBloc.get(ctx);
              return SizedBox(
                height: bloc.showCountWidget ? ((Platform.isIOS?  86.w : 88.w) + 125.h) : ((Platform.isIOS?  58.w : 38.w) + 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    //     child: QuickCheckOutButton(amount: widget.item.price, list: [widget.item],amWalListen: true,),
                    // ),
                    AddToCartButtonWidget(item: widget.item,),
                    const BottomNavBar(isRoot: false ),
                  ],
                ),
              );
            },
          ),
        ),

      ],
    );
  }


}