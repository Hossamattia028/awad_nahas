import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:awad_nahas/features/categories/data/repositories/category_model_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../products/mockito_data/test_helper.mocks.dart';
import '../../mockito_data/test_helper.mocks.dart';

void main(){
  late CategoryModelRepository categoryModelRepository;
  late MockCategoryRemoteDataSource mockCategoryRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;


  setUp(() {
    mockCategoryRemoteDataSource = MockCategoryRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    categoryModelRepository = CategoryModelRepository(categoryRemoteDataSource: mockCategoryRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  var  responseModel = const [
    CategoriesModel(id: 296, slug: "slug", imgPath: "imgPath", title: "title",
        desc: "desc", iconPath: "iconPath", darkIcon: "darkIcon", lightIcon: "lightIcon", isArabic: true,
        parentID: "", productsCount: 10, enableHomeScreen: true),
  ];

  test("products model repository", () async {
    // Arrange
    when(mockCategoryRemoteDataSource.getAllCategory())
        .thenAnswer((_) async => responseModel);
    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    // Act
    final result = await categoryModelRepository.getAllCategories();

    // Assert
    expect(result, equals(Right<CategoriesModel, dynamic>(responseModel)));
  });


  test("should return server failure when call the function inside data source ", () async {
    // Arrange
    when(mockCategoryRemoteDataSource.getAllCategory())
        .thenThrow(ServerException());

    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    // Act
    final result = await categoryModelRepository.getAllCategories();

    // Assert
    expect(result, equals(Left(ServerFailure())));
  });

  test("should return OfflineFailure when set connect as false", () async {
    // Arrange
    when(mockCategoryRemoteDataSource.getAllCategory())
        .thenAnswer((_) async => responseModel);

    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

    // Act
    final result = await categoryModelRepository.getAllCategories();

    // Assert
    expect(result, equals(Left(OfflineFailure())));
  });
}