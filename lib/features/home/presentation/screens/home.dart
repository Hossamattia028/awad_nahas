// ignore_for_file: use_build_context_synchronously

import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/notifications_utils.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/search/presentation/screens/search_screen.dart';
import 'package:awad_nahas/features/search/presentation/widgets/search_widget.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/home/presentation/widgets/home_content.dart';
import 'package:awad_nahas/features/shared_widgets/logo_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:rate_my_app/rate_my_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'awadnahas',
    minDays: 0, // Show rate popup on first day of install.
    minLaunches: 5, // Show rate popup after 5 launches of app after minDays is passed.
    googlePlayIdentifier: 'com.awadnahas.awadnahas',
    appStoreIdentifier: 'com.awadnahas.ios',
  );

  @override
  void initState() {
    NotificationsUtils.pushNotificationListener(context);

    if(!SharedPref().containPreference("rating")){
      rateMyApp.init().then((_){
        SharedPref().setPreferencesBoolean("rating", true);
        // if(rateMyApp.shouldOpenDialog){ //conditions check if user already rated the app
          rateMyApp.showStarRateDialog(
            context,
            title: translate("rate.title"),
            message: translate("rate.leave_rating"),
            actionsBuilder: (_, stars){
              return [ // Returns a list of actions (that will be shown at the bottom of the dialog).
                CustomButton(
                    height: 35.h,
                    width: double.infinity,
                    widget:  CustomText(
                      text: translate("button.ok"),
                      fontSize: AppStyle.average.sp,
                      color: Colors.white,
                    ),
                    color: DMUtil.getRED(),
                    onPressed: ()async{
                      debugPrint('Thanks for the ${stars == null ? '0' : stars.round().toString()} star(s) !');
                      if(stars != null && (stars == 4 || stars == 5)){
                        //if the user stars is equal to 4 or five
                        // you can redirect the use to playstore or                         appstore to enter their reviews

                      } else {
                        // else you can redirect the user to a page in your app to tell you how you can make the app better

                      }
                      // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                      // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                      await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                      Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
                    },
                ),
              ];
            },
            // ignoreNativeDialog: Platform.isIOS,
            dialogStyle: const DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20.0),
            ),
            starRatingOptions: const StarRatingOptions(),
            onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
          );
        // }
      });
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=> onRefresh(context),
      color: DMUtil.getRED(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppStyle.paddingFromH.sp,),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppStyle.paddingFromTop.h-10,),
            const LogoWidget(width: 140,height: 80,fit: BoxFit.contain,),
            const SizedBox(height: 10,),
            const SearchWidget(),
            SizedBox(height: 6.w,),
            // const SelectLocations(),

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

  Future onRefresh(BuildContext context)async{
    ProductsBloc.get(context).add(const FetchAllProductsEvent());
    // CategoriesBloc.get(context).add(const FetchMainSlidersEvent());
    CategoriesBloc.get(context).add(const FetchAllCategoriesEvent());
    CategoriesBloc.get(context).add(const FetchAllBrandsEvent());
  }
}









