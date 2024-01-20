import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/domain/use_cases/get_all_categories_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_helper.mocks.dart';



void main() {
  group('Categories', () {
    late GetAllCategoryUseCase getAllCategoryUseCase;
    late MockCategoryRepository mockCategoriesRepository;

    setUp(() {
      mockCategoriesRepository = MockCategoryRepository();
      getAllCategoryUseCase = GetAllCategoryUseCase(categoryRepository: mockCategoriesRepository);
    });

    List<CategoriesEntity> res = [
      const CategoriesEntity(title: "title", desc: "desc", id: 1, slug: "slug", imgPath: "imgPath", iconPath: "iconPath", isArabic: false, parentID: "parentID", productsCount: 10)
    ];

    test('Get all categories', () async {
      // arrange
      when(mockCategoriesRepository.getAllCategories()).thenAnswer((realInvocation) async => Right(res));

      // act
      final result = await getAllCategoryUseCase.call();

      // assert
      expect(result, isNotNull);
      expect(result,  Right(res));
      // verify(() => mockCategoriesRepository.getAllCategories());
      // verifyNoMoreInteractions(mockCategoriesRepository);
    });




  });
}