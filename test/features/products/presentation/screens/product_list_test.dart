import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:awad_nahas/features/products/presentation/screens/products_list.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProductsBloc extends MockBloc<ProductsEvent, ProductsState> implements ProductsBloc {}

void main() {
  late MockProductsBloc mockProductsBloc;

  setUp(() {
    mockProductsBloc = MockProductsBloc();
  });

  Widget testWidgetMK(Widget body) {
    return BlocProvider<ProductsBloc>(
      create: (context) => mockProductsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('product list widget', (widgetTester) async {
    // Arrange
    when(mockProductsBloc.state).thenReturn(const ProductsLoadingState());

    // Act
    await widgetTester.pumpWidget(testWidgetMK(const ProductListScreen(catID: "most", subCatID: -1)));

    await widgetTester.pump();
  });
}
