import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_bloc.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_event.dart';
import 'package:awad_nahas/features/products/presentation/bloc/products_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mockito_data/test_helper.mocks.dart';

void main() {
  late MockGetAllProductsUseCase mockGetAllProductsUseCase;
  late MockGetAllProductCommentsUseCase mockGetAllProductCommentsUseCase;
  late MockAddProductCommentUseCase mockAddProductCommentUseCase;
  late ProductsBloc productsBloc;

  setUp(() {
    mockGetAllProductsUseCase = MockGetAllProductsUseCase();
    mockGetAllProductCommentsUseCase = MockGetAllProductCommentsUseCase();
    mockAddProductCommentUseCase = MockAddProductCommentUseCase();
    productsBloc = ProductsBloc(
        getAllProductsUseCase: mockGetAllProductsUseCase,
        getAllProductCommentsUseCase: mockGetAllProductCommentsUseCase,
        addProductCommentUseCase: mockAddProductCommentUseCase);
  });

  const  res = ProductResponseModel(products: [], productsCount: 100);
  blocTest<ProductsBloc, ProductsState>('get all products failed count from products bloc by [event]',
      build: () {
        when(mockGetAllProductsUseCase(parameter: "100"))
            .thenAnswer((_) async =>  const Right(res));
        return productsBloc;
      },
      act: (bloc) => bloc.add(const FetchAllProductsEvent()),
      expect: ()=> const [
        ProductsLoadingState(),
        ProductsFailedState(),
      ],
     wait: const Duration(seconds: 2)
  );

  blocTest<ProductsBloc, ProductsState>('get all products from products bloc by [event]',
      build: () {
        when(mockGetAllProductsUseCase(parameter: "300"))
            .thenAnswer((_) async =>  const Right(res));
        return productsBloc;
      },
      act: (bloc) => bloc.add(const FetchAllProductsEvent()),
      expect: ()=> const [
        ProductsLoadingState(),
        // ProductsSuccessfullyState(),
      ],
      wait: const Duration(seconds: 4)
  );
}
