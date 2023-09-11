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
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/product_desc.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/shipping_installment.dart';
import 'package:awad_nahas/features/shared_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProductDetailsDataRow extends StatefulWidget {
  final ProductsEntity item;
  const ProductDetailsDataRow({Key? key,required this.item}) : super(key: key);

  @override
  State<ProductDetailsDataRow> createState() => _ProductDetailsDataRowState();
}

class _ProductDetailsDataRowState extends State<ProductDetailsDataRow> {
  String desc = "";
  _getDesc()async {
    desc = await ProductsRemoteDataSource.getProductDetails(id:  widget.item.id);
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
    double heightDesc = desc.length>212?420:200;
    if(desc.length>400)heightDesc= 500;
    if(desc.length>490)heightDesc= 550;
    if(desc.length>700)heightDesc= 800;
    if(desc.length>1000)heightDesc= 1200;
    if(desc.length>1400)heightDesc= 1490;
    if(desc.length>1900)heightDesc= 1500;
    return DefaultTabController(
        length: 3,
        child: BlocBuilder<ProductsBloc,ProductsState>(
          builder: (ctx,state){
            var bloc = ProductsBloc.get(ctx);
            if(bloc.index==0)bloc.widgetSize = heightDesc;
            return SizedBox(
              height: bloc.widgetSize,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TabBar(
                    onTap: (index) => bloc.add(ChangeWidgetSizeEvent(height: index==0?heightDesc:index==1?300.h:585.h,index: index)),
                    // indicatorPadding: const EdgeInsets.symmetric(horizontal: 6),
                    unselectedLabelColor: DMUtil.getDC(),
                    indicatorColor: DMUtil.getPC(),
                    labelColor: DMUtil.getPC(),
                    // isScrollable: true,
                    labelStyle: TextStyle(color: DMUtil.getPC(),fontSize: AppStyle.small.sp+2,fontFamily: primaryFontReg),
                    tabs: <Widget>[
                      Tab(text: translate("products.desc"),),
                      Tab(text: translate("products.reviews"),),
                      Tab(text: translate("products.shipping_delivery"),),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        desc==""? const LoadingWidget(height: 30,): ProductDescriptionWidget(txt:  desc,),
                        const CommentList(),
                        const ShippingAndInstallmentWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}
