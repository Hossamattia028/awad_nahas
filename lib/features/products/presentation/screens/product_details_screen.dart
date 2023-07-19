import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/images_slider.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_comments.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_desc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/related_products.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/select_product_quantity_widget.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/products/presentation/widgets/rate_widget.dart';
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
      appBar: GlobalAppBar(
        title: "pop",// for pop the search textField after search
        justLogo: true,
        leadingIcon: GlobalWidgets.backArrowButton(()=> Navigator.pop(context), kSecondPrimary, Alignment.center),
      ),
      bottomNavigationBar: AddToCartButtonBottomNav(item: widget.item,),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagesSlider(images: [widget.item.imgPath,],),
            const SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectProductQuantityWidget(item: widget.item,),
                const RateWidget(countRate: 300),
              ],
            ),

            const Divider(thickness: 1,),

            CustomText(
                text: catListString,
                color: kBackBlueColor,
                fontSize: AppStyle.small.sp,
            ),

            CustomText(
                text: widget.item.title,
                color: kText1,
                fontWeight: FontWeight.w700,
                fontSize: AppStyle.small.sp,
            ),
            const Divider(thickness: 1,),
            ProductPriceWidget(productModel: widget.item,isBig: true,),
            ProductDescription(desc: widget.item.desc,),
            const ProductCommentsWidget(),

            const RelatedProductsWidget(),

          ],
        )
      ),
    );
  }


}