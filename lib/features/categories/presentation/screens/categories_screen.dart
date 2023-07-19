import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/home/presentation/widgets/categories.dart';
import 'package:awad_nahas/features/home/presentation/widgets/main_slider.dart';
import 'package:awad_nahas/features/search/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoriesScreen> {


  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10.w),
        child: Column(
          children: [
            const SearchWidget(),
            const SizedBox(height: 10,),
            BlocBuilder<CategoriesBloc,CategoriesState>(
              builder: (ctx,state){
                var bloc = CategoriesBloc.get(ctx);
                if(bloc.categorySlider==null)return const SizedBox.shrink();
                return const SliderWidget(height: 100,);
              },
            ),

            const HomeCategories(viewAll: true,),



          ],
        ),
      ),
    );
  }
}


