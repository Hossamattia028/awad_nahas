import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:awad_nahas/features/products/data/repositories/products_model_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mockito_data/test_helper.mocks.dart';

void main(){
  late ProductsModelRepository productsModelRepository;
  late MockProductsRemoteDataSource mockProductsRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;


  setUp(() {
    mockProductsRemoteDataSource = MockProductsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    productsModelRepository = ProductsModelRepository(productsRemoteDataSource: mockProductsRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  const  responseModel = ProductResponseModel(products: [], productsCount: 300);
  test("products model repository", () async {
    // Arrange
    when(mockProductsRemoteDataSource.getAllProducts(parameter: "300"))
        .thenAnswer((_) async => responseModel);
    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    // Act
    final result = await productsModelRepository.getAllProducts(parameter: "300");

    // Assert
    expect(result, equals(const Right<ProductResponseModel, dynamic>(responseModel)));
  });


  test("should return server failure when call the function inside data source ", () async {
    // Arrange
    when(mockProductsRemoteDataSource.getAllProducts(parameter: "300"))
        .thenThrow(ServerException());

    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    // Act
    final result = await productsModelRepository.getAllProducts(parameter: "300");

    // Assert
    expect(result, equals(Left(ServerFailure())));
  });

  test("should return OfflineFailure when set connect as false", () async {
    // Arrange
    when(mockProductsRemoteDataSource.getAllProducts(parameter: "300"))
        .thenAnswer((_) async => responseModel);

    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

    // Act
    final result = await productsModelRepository.getAllProducts(parameter: "300");

    // Assert
    expect(result, equals(Left(OfflineFailure())));
  });
}