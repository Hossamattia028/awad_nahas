import 'package:awad_nahas/core/strings/app_images.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/cart_icon.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_event.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';

class BottomNavBar extends StatelessWidget {
  final bool isRoot;
  const BottomNavBar({Key? key,this.isRoot = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc,RootState>(
      builder: (ctx,state){
        var bloc = RootBloc.get(ctx);
        int currentIndex = bloc.currentScreenIndex;
        return BottomNavigationBar(
          onTap: (index){
            if(isRoot == false){
              Util.pushPageAndRemoveRoutes(const RootScreen(), context);
            }
            if(index==0){
              bloc.add(const SearchEvent(word: '',categoryList: [],productList: []));
              ProductsBloc.get(context).add(const FilterProductEvent(filterModel: null));
            }
            bloc.add(ChangeIndex(index: index, title: ""));
          },
          currentIndex: currentIndex,
          backgroundColor: DMUtil.getWC(),
          selectedItemColor: DMUtil.getRED(),
          unselectedItemColor: DMUtil.getDC(),
          selectedLabelStyle: TextStyle(fontFamily: primaryFontReg,height: 1.4,),
          unselectedLabelStyle: TextStyle(fontFamily: primaryFontReg,height: 1.4),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.homeSelected, colorFilter: ColorFilter.mode(currentIndex==0?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),),label: translate("app_bar.home"),backgroundColor: DMUtil.getWC()),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.categorySelected, colorFilter: ColorFilter.mode(currentIndex==1?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),),label: translate("app_bar.categories"),backgroundColor: DMUtil.getWC()),
            BottomNavigationBarItem(icon: WishListNavIconWidget(selected: currentIndex==2) ,label: translate("wishlist.title"),backgroundColor: DMUtil.getWC()),
            BottomNavigationBarItem(icon: CartNavIconWidget(selected: currentIndex==3),label: translate("app_bar.cart"),backgroundColor: DMUtil.getWC()),
            BottomNavigationBarItem(icon: SvgPicture.asset(AppImages.accountSelected, colorFilter: ColorFilter.mode(currentIndex==4?DMUtil.getRED():DMUtil.getD2C(), BlendMode.srcIn),) ,label: translate("profile.my_account"),backgroundColor: DMUtil.getWC()),
          ],
        );
      },
    );
  }
}



