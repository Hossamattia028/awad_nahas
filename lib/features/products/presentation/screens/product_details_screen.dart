import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/payment_utils/tamara/tamara_widgets.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/brand_products.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/images_slider.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_attributes.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_details_data_taps.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/related_products.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';



class ProductDetailPage extends StatefulWidget {
  final ProductsEntity item;
  const ProductDetailPage({Key? key,required this.item}): super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>  {
  String catListString = "";
  late ProductsBloc productsBloc;
  double currentPrice = 0.0;

  @override
  void didChangeDependencies() {
    currentPrice = widget.item.price!=widget.item.discount&&widget.item.discount!=0?widget.item.discount:widget.item.price;
    if(widget.item.categoryList.isNotEmpty){
      for(var i in widget.item.categoryList){
        catListString += i.title;
      }
    }
    productsBloc = ProductsBloc.get(context);
    productsBloc.add(UpdateCurrentProduct(item: widget.item));
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
        backGroundColor: DMUtil.getRED(),
        title: widget.item.title,
        textColor: Colors.white,
        leadingIcon: const BackArrowButton(color: Colors.white,),
      ),
      bottomNavigationBar: AddToCartButtonWidget(item: widget.item,),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WishListIconWidget(item: widget.item),
                const SizedBox(width: 10,),
                InkWell(
                  onTap: ()=> Share.share('check the website http://demo.awadnahas.com/', subject: widget.item.title.toString()),
                  child: Icon(Icons.ios_share_outlined,color: DMUtil.getRED(),),
                ),
              ],
            ),

            if(widget.item.images!=null && widget.item.images!.isNotEmpty)...[
              ImagesSlider(images: widget.item.images!,),
            ]else ...[
              ImagesSlider(images: [
                widget.item.imgPath
              ],),
            ],

            const SizedBox(height: 10,),

            CustomText(
              text: widget.item.title,
              color: DMUtil.getDC(),
              fontSize: AppStyle.large.sp-3,
              maxLine: 2,
            ),


            const Divider(thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductPriceWidget(productModel: widget.item,isBig: true,),

                BlocBuilder<CategoriesBloc,CategoriesState>(
                  builder: (ctx,state){
                    var bloc = CategoriesBloc.get(ctx);
                    int index = bloc.brandsList.indexWhere((element) => element.id==widget.item.brandID);
                    if(index == -1) return const SizedBox.shrink();
                    var brand = bloc.brandsList[index];
                    if(brand.iconPath.contains("svg")){
                      return SvgPicture.network(brand.iconPath,width: 26.w,height: 35.h,);
                    }else{
                      return Image.network(brand.imgPath);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 5,),
            if(widget.item.attributesDes!=null)ProductAttributes(txt: widget.item.attributesDes!),
            const SizedBox(height: 10,),
            if(Util.checkUser() && currentPrice<=2000)...[
              const SizedBox(height: 5,),
              TamaraSmallProductWidget(price: currentPrice),
              const SizedBox(height: 10,),
            ],

           ProductDetailsDataRow(item: widget.item),


            if(widget.item.brandID!=null)
            BlocBuilder<CategoriesBloc,CategoriesState>(
              builder: (ctx,state){
                var bloc = CategoriesBloc.get(ctx);
                int index = bloc.brandsList.indexWhere((element) => element.id==widget.item.brandID);
                if(index == -1) return const SizedBox.shrink();
                var brand = bloc.brandsList[index];
                return BrandProductsWidget(item:  widget.item,brandTitle: brand.title,);
              },
            ),

            RelatedProductsWidget(item:  widget.item,),

          ],
        )
      ),
    );
  }


}