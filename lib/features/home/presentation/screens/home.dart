import 'package:awad_nahas/features/locations/presentation/widgets/select_location_drop_down.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/search/presentation/screens/search_screen.dart';
import 'package:awad_nahas/features/search/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/home/presentation/widgets/home_content.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/shared_widgets/logo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:_onRefresh,
      color: kPrimary,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.sp,),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppStyle.paddingFromTop.h,),
            const LogoWidget(width: 120,height: 70,fit: BoxFit.contain,),
            const SizedBox(height: 10,),
            const SearchWidget(),

            const SelectLocations(),

            BlocBuilder<ProductsBloc,ProductsState>(
              builder: (ctx,state){
                var bloc = ProductsBloc.get(ctx);
                return  bloc.enableSearch? const SearchScreen() : const HomeContentWidget();
              },
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh()async{
    ProductsBloc.get(context).add(const FetchAllProductsEvent());
    ProductsBloc.get(context).add(const FetchAllLatestProductsEvent());
    ProductsBloc.get(context).add(const FetchAllBestSellerProductsEvent());
    // CategoriesBloc.get(context).add(const FetchMainSlidersEvent());
    CategoriesBloc.get(context).add(const FetchAllCategoriesEvent());
  }
}




