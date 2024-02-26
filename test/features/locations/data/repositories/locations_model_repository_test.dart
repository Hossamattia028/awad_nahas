import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/locations/data/repositories/locations_model_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../products/mockito_data/test_helper.mocks.dart';
import '../../mockito_data/test_helper.mocks.dart';

void main(){
  late LocationsModelRepository locationsModelRepository;
  late MockLocationRemoteDataSource mockLocationRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;


  setUp(() {
    mockLocationRemoteDataSource = MockLocationRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    locationsModelRepository = LocationsModelRepository(locationRemoteDataSource: mockLocationRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  const  locationModel = LocationModel(
      address1: "address1", address2: "address2", city: "city", phone: "201123876427", state: "state", country: "country",
      id: 0, type: "", lat: 23, long: 23, postCode: "postCode",
      lastName: "lastName", firstName: "firstName", email: "email", locationType: "locationType");

  var responseModel = const AddressModel(shippingAddress: locationModel, billingAddress: locationModel);

  test("locations model repository", () async {
    // Arrange
    when(mockLocationRemoteDataSource.fetchAllLocations())
        .thenAnswer((_) async => responseModel);
    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    // Act
    final result = await locationsModelRepository.fetchAllLocations();

    // Assert
    expect(result, equals(Right<AddressModel, dynamic>(responseModel)));
  });


  test("should return server failure when call the function inside data source ", () async {
    // Arrange
    when(mockLocationRemoteDataSource.fetchAllLocations())
        .thenThrow(ServerException());

    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    // Act
    final result = await locationsModelRepository.fetchAllLocations();

    // Assert
    expect(result, equals(Left(ServerFailure())));
  });

  test("should return OfflineFailure when set connect as false", () async {
    // Arrange
    when(mockLocationRemoteDataSource.fetchAllLocations())
        .thenAnswer((_) async => responseModel);

    when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);

    // Act
    final result = await locationsModelRepository.fetchAllLocations();

    // Assert
    expect(result, equals(Left(OfflineFailure())));
  });
}