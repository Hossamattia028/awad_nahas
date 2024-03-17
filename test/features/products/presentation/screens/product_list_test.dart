import 'dart:io';

import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/products_list.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../../core/util_test.dart';

class MockProductsBloc extends MockBloc<ProductsEvent, ProductsState>
    implements ProductsBloc {
  @override
  List<ProductsEntity> get productsList => [];
  @override
  List<ProductsEntity> get bestSellerProductsList => [];
  @override
  List<ProductsEntity> get latestSellerProductsList => [];
}

class FakeRegisterState extends Fake implements ProductsState {}

void main() {
  late ProductsBloc productsBloc;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakeRegisterState());
  });

  setUp(() async{
    await TestHelper.initalWidgetTesting();
    productsBloc = MockProductsBloc();
  });

  Widget rootWidget(Widget body) {
    return BlocProvider<ProductsBloc>.value(
      value: productsBloc,
      child: ScreenUtilInit(
          designSize: const Size(375, 667),
          child: Localizations(delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ], locale: const Locale('en'), child: MaterialApp(home: body))),
    );
  }

  testWidgets('product list widget', (tester) async {
    // Arrange
    when(() => productsBloc.state).thenReturn(const ProductsLoadingState());
    await tester.pumpWidget(rootWidget(const ProductListScreen(catID: "most", subCatID: -1)));
    await tester.pumpAndSettle(const Duration(microseconds: 100));
  });
}
