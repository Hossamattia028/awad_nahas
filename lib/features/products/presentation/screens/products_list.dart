import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_card.dart';
import 'package:awad_nahas/features/shared_widgets/empty_data_widget.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';

class ProductListScreen extends StatelessWidget {
  final String catID;
  const ProductListScreen({Key? key,required this.catID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: "",
        justLogo: true,
        leadingIcon: GlobalWidgets.backArrowButton(()=> Navigator.of(context).pop(),kText1,Alignment.center,),
      ),
      body: BlocBuilder<ProductsBloc,ProductsState>(
        builder: (ctx,state){
          var bloc = ProductsBloc.get(ctx);
          var list = bloc.productsList;
          if(catID=="most"){
            list = bloc.bestSellerProductsList;
          }else if (catID=="last"){
            list = bloc.latestSellerProductsList;
          }else{
            list = bloc.filterByCategoryID(int.tryParse(catID)??0);
          }
          if(list.isEmpty)return EmptyDataWidget(txt: translate("products.empty"),);
          return ListView.separated(
            padding: EdgeInsets.all(10.h),
            itemCount: list.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var item = list[index];
              return ProductCard(item: item);
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      )
    );
  }
}
