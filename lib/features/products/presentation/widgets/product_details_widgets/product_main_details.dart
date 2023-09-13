import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/images_slider.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_price.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class ProductMainDetails extends StatelessWidget {
  final ProductsEntity item;
  const ProductMainDetails({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10),
      color: DMUtil.getWC(),
      child: Column(
        children: [
          CustomText(
            text: item.title,
            color: DMUtil.getD2C().withOpacity(0.9),
            fontWeight: FontWeight.w600 ,
            fontSize: AppStyle.large.sp-1,
            maxLine: 2,
          ),
          const SizedBox(height: 5,),
          Stack(
            alignment: Util.getLang()=="ar"? Alignment.topLeft :Alignment.topRight,
            children: [
              if(item.images!=null && item.images!.isNotEmpty)...[
                ImagesSlider(images: item.images!,height: 250,),
              ]else ...[
                ImagesSlider(images: [
                  item.imgPath
                ],height: 250,),
              ],
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 10,),

                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0) + const EdgeInsets.only(top: 2),
                      child: WishListIconWidget(item: item),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: ()=> Share.share('check the website ${ApiUrl.MAIN_DOMAIN}/', subject: item.title.toString()),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.share,color: DMUtil.getOpacity(),size: 20.w,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),

          const SizedBox(height: 15,),



          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductPriceWidget(productModel: item,isBig: true,),
              BlocBuilder<CategoriesBloc,CategoriesState>(
                builder: (ctx,state){
                  var bloc = CategoriesBloc.get(ctx);
                  int index = bloc.brandsList.indexWhere((element) => element.id==item.brandID);
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
        ],
      ),
    );
  }
}
