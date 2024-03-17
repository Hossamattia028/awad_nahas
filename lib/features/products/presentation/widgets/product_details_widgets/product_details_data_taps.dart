import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/comment_list.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/prodcut_desc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_attributes.dart';
import 'package:awad_nahas/features/shared_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductDetailsDataRow extends StatefulWidget {
  final ProductsEntity item;
  const ProductDetailsDataRow({super.key,required this.item});

  @override
  State<ProductDetailsDataRow> createState() => _ProductDetailsDataRowState();
}

class _ProductDetailsDataRowState extends State<ProductDetailsDataRow> {
  String desc = "";
  _getDesc()async {
    if(!mounted)return;
    desc = await ProductsRemoteDataSourceImpl.getProductDetails(id:  widget.item.id);
    if(desc != ""){
      if(mounted)setState(() {});
    }
  }
  @override
  void initState() {
    _getDesc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: BlocBuilder<ProductsBloc,ProductsState>(
          builder: (ctx,state){
            var bloc = ProductsBloc.get(ctx);
            // if(bloc.index==0 && bloc.showFullContent ==true){
            //   if(desc.length>490) bloc.widgetSize= 500;
            // }else{
            //   bloc.widgetSize= 220;
            // }
            double val = 30.h+10.w;
            return Container(
              color: DMUtil.getWC(),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: val,
                    child: TabBar(
                      onTap: (index) => bloc.add(ChangeWidgetSizeEvent(height: index==0?bloc.widgetSize:250,index: index)),
                      unselectedLabelColor: DMUtil.getDC(),
                      indicatorColor: DMUtil.getPC(),
                      labelColor: DMUtil.getPC(),
                      isScrollable: true,
                      labelPadding: EdgeInsets.symmetric(horizontal: 20.w,),
                      labelStyle: TextStyle(color: DMUtil.getPC(),fontSize: AppStyle.small.sp+2,fontFamily: primaryFontReg,fontWeight: FontWeight.w600),
                      tabs: <Widget>[
                        Tab(text: translate("products.desc"),height: val,),
                        Tab(text: translate("cart.attributes"),height: val,),
                        Tab(text: translate("products.reviews"),height: val,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),

                  if(bloc.index==0)desc==""? const LoadingWidget(height: 30,):ProductDescriptionWidget(txt:  desc,),
                  // (bloc.showFullContent? ProductDescriptionWidget(txt:  desc,): SizedBox(height:bloc.widgetSize,child: ProductDescriptionWidget(txt:  desc,),)),
                  if(bloc.index==1)widget.item.attributesDes!=null ? ProductAttributes(txt: widget.item.attributesDes!) : const SizedBox.shrink(),
                  if(bloc.index==2)const CommentList(),

                  const SizedBox(height: 10,),
                ],
              ),
            );
          },
        )
    );
  }
}
