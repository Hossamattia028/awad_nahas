import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/home/presentation/widgets/main_slider.dart';
import 'package:awad_nahas/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/brand_products.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_details_data_taps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/related_products.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';



class ProductDetailPage extends StatefulWidget {
  final ProductsEntity item;
  const ProductDetailPage({Key? key,required this.item}): super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>  {
  List selectedOptions = [];
  double lowPrice = 0;
  double highPrice = 0;
  double currentPrice = 0;
  double salePrice = 0;
  String currentImg = "";
  String currentDesc = "";
  bool isVariationProduct = false;

  String catListString = "";
  late ProductsBloc productsBloc;
  @override
  void didChangeDependencies() {
    if(widget.item.categoryList.isNotEmpty){
      for(var i in widget.item.categoryList){
        catListString += i.title;
      }
    }
    productsBloc = ProductsBloc.get(context);
    productsBloc..add(UpdateCurrentProduct(item: widget.item))..add(const FetchProductCommentsEvent());
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: const GlobalAppBar(
        title: "",
        leadingIcon: BackArrowButton(),
      ),
      bottomNavigationBar: AddToCartButtonBottomNav(item: widget.item,),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SliderWidget(),

            const SizedBox(height: 10,),

            CustomText(
                text: widget.item.title,
                color: DMUtil.getDC(),
                fontSize: AppStyle.large.sp-3,
            ),
            Image.asset("${AppImages.images}/brand.png"),
            const Divider(thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductPriceWidget(productModel: widget.item,isBig: true,),
                Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Icon(Icons.favorite_border,color: DMUtil.getD2C(),),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: (){},
                      child: Icon(Icons.ios_share_outlined,color: DMUtil.getD2C(),),
                    ),
                  ],
                )
              ],
            ),
            const Divider(thickness: 1,),

            ProductDetailsDataRow(item: widget.item),

            const BrandProductsWidget(),

            const RelatedProductsWidget(),

          ],
        )
      ),
    );
  }


}