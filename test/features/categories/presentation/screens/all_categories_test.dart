import 'dart:io';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/screens/all_categories.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../../core/util_test.dart';

class MockCategoriesBloc extends MockBloc<CategoriesEvent, CategoriesState>
    implements CategoriesBloc {
  @override
  List<CategoriesEntity> get categoriesList => [];
}

class FakeRegisterState extends Fake implements CategoriesState {}

void main() {
  late CategoriesBloc categoriesBloc;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakeRegisterState());
  });

  setUp(() async{
    await TestHelper.initalWidgetTesting();
    categoriesBloc = MockCategoriesBloc();
  });

  Widget rootWidget(Widget body) {
    return BlocProvider<CategoriesBloc>.value(
      value: categoriesBloc,
      child: ScreenUtilInit(
          designSize: const Size(375, 667),
          child: Localizations(delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ], locale: const Locale('en'), child: MaterialApp(home: body))),
    );
  }

  testWidgets('all categories list widget', (tester) async {
    // Arrange
    when(() => categoriesBloc.state).thenReturn(const FetchCategoriesSuccessfullyState());
    await tester.pumpWidget(rootWidget(const AllCategoriesList()));
    await tester.pumpAndSettle(const Duration(microseconds: 100));
  });
}
