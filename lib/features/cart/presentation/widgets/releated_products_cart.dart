import 'package:awad_nahas/features/products/presentation/widgets/product_details_widgets/related_products.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/empty_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartRelatedProducts extends StatelessWidget {
  const CartRelatedProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CartBloc,CartState>(
      builder: (ctx,state){
        var bloc = CartBloc.get(ctx);
        var list = bloc.cartList;
        if(list.isEmpty)return const SizedBox.shrink();
        int ind = ProductsBloc.get(context).productsList.indexWhere((element) => list.first.id==element.id);
        if(ind==-1)return const SizedBox.shrink();
        var item = ProductsBloc.get(context).productsList[ind];
        if(list.isEmpty)return const EmptyCartWidget();
        return RelatedProductsWidget(item:  item,);
      },
    );
  }
}
