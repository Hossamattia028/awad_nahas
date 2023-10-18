import 'package:awad_nahas/core/utils/notifications_utils.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/root_app/screens/root_screen.dart';
import 'package:awad_nahas/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:awad_nahas/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awad_nahas/core/utils/shared_pref.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:awad_nahas/features/shared_widgets/error_widget.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'injection_container.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Future.wait([
    Firebase.initializeApp(),
    di.init(),
    SharedPref().instantiatePreferences()
  ]);
  await NotificationsUtils.initialPushNotification();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'ar']);
  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget {
  final bool? isTheme;
  const MyApp({Key? key,this.isTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context,widget)  => MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => di.sl<RootBloc>()),
          BlocProvider(create: (ctx) => di.sl<AuthBloc>()),
          BlocProvider(create: (ctx) => di.sl<AccountBloc>()),
          BlocProvider(create: (ctx) => di.sl<LocationsBloc>()),
          BlocProvider(create: (ctx) => di.sl<CategoriesBloc>()..add(const FetchMainSlidersEvent())),
          BlocProvider(create: (ctx) => di.sl<ProductsBloc>()),
          BlocProvider(create: (ctx) => di.sl<WishlistBloc>()),
          BlocProvider(create: (ctx) => di.sl<CartBloc>()),
          BlocProvider(create: (ctx) => di.sl<OrderBloc>()),
        ],
        child: LocalizationProvider(
          state: LocalizationProvider.of(context).state,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: Util.getLang()=="en_US"?localizationDelegate.supportedLocales.first:localizationDelegate.supportedLocales.last,
            builder: (BuildContext? context, Widget? widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomError(errorDetails: errorDetails);
              };
              return widget!;
            },
            title: 'AwadNahas',
            home: isTheme==true?  const RootScreen(): const SplashScreen(),
          ),
        ),
      )
    );
  }
}

