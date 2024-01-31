import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:awad_nahas/features/products/domain/use_cases/products_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_helper.mocks.dart';



void main() {
  group('Products', () {
    late GetAllProductsUseCase getAllProductsUseCase;
    late MockProductsRepository mockProductsRepository;

    setUp(() {
      mockProductsRepository = MockProductsRepository();
      getAllProductsUseCase = GetAllProductsUseCase(productsRepository: mockProductsRepository);
    });
    const  res =   ProductResponseModel(products: [], productsCount: 100);

    test('Get all products', () async {
      // arrange
      when(mockProductsRepository.getAllProducts(parameter: "100")).thenAnswer((realInvocation) async => const Right(res));

      // act
      final result = await getAllProductsUseCase(parameter: "100");

      // assert
      expect(result, isNotNull);
      expect(result, const Right(res));
      // verify(() => mockProductsRepository.getAllProducts(parameter: "100"));
      // verifyNoMoreInteractions(mockProductsRepository);
    });
  });
}