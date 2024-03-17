import 'dart:io';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/coupon_widget.dart';
import 'package:awad_nahas/features/products/data/models/product_attributes.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text_form_field.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../../core/util_test.dart';

class TestMockCartBloc extends MockBloc<CartEvent, CartState>
    implements CartBloc {
  TestMockCartBloc() : super();

  @override
  List<ProductsEntity> cartList = [
    ProductsEntity(
        id: 15432,
        sku: "TSF01PGUK",
        title: "Smeg 50's Style Retro Aesthetic 2 Slice Toaster, Pastel Green",
        priceWithoutTax: 20,
        price: 22,
        imgPath: "imgPath",
        images: const [],
        catTitle: "catTitle",
        desc: "desc",
        attributesDes: "attributesDes",
        discount: 20,
        discountRate: 1,
        stockStatus: false,
        quantity: 2,
        categoryList: const [],
        catID: 1,
        brandID: 1,
        commentCount: 2,
        isArabic: true,
        reviewsList: const [],
        date: "date",
        averageRate: "10",
        attributes: ProductAttributes(
            height: 2, width: 2, length: 2, weight: 2, color: "color"))
  ];
}

class FakeRegisterState extends Fake implements CartState {}

void main() async {
  late CartBloc cartBloc;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakeRegisterState());
  });

  setUp(() async{
    await TestHelper.initalWidgetTesting();
    cartBloc = TestMockCartBloc();
  });

  Widget rootWidget(Widget body) {
    return BlocProvider<CartBloc>.value(
      value: cartBloc,
      child: ScreenUtilInit(
          designSize: const Size(375, 667),
          child: Localizations(delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ], locale: const Locale('en'), child: MaterialApp(home: body))),
    );
  }

  testWidgets('Coupon Widget Tested', (WidgetTester tester) async {
    when(() => cartBloc.state).thenReturn(const CartLoadingState());

    await tester.pumpWidget(rootWidget(const Material(child: CouponWidget())));
    await tester.pumpAndSettle(const Duration(microseconds: 100));

    // debugDumpApp();
    expect(find.byType(CustomTextFromField), findsOneWidget);
    expect(find.text('cart.coupon'), findsOneWidget);
    expect(find.text('cart.active_coupon'), findsOneWidget);
  });
}
