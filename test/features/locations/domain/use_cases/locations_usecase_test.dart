import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/locations/domain/use_cases/locations_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mockito_data/test_helper.mocks.dart';



void main() {
  late FetchUserLocationsUseCase fetchUserLocationsUseCase;
  late MockLocationsRepository mockProductsRepository;

  setUp(() {
    mockProductsRepository = MockLocationsRepository();
    fetchUserLocationsUseCase = FetchUserLocationsUseCase(locationsRepository: mockProductsRepository);
  });

  group('Locations', () {

    test('Get all locations useCase', () async {
      // arrange
      const  locationModel = LocationModel(
          address1: "address1", address2: "address2", city: "city", phone: "201123876427", state: "state", country: "country",
          id: 0, type: "", lat: 23, long: 23, postCode: "postCode",
          lastName: "lastName", firstName: "firstName", email: "email", locationType: "locationType");

      var responseModel = const AddressModel(shippingAddress: locationModel, billingAddress: locationModel);

      when(mockProductsRepository.fetchAllLocations()).thenAnswer((_) async =>  Right(responseModel));

      // act
      final result = await fetchUserLocationsUseCase();

      // assert
      expect(result, isNotNull);
      expect(result, Right(responseModel));
      verify(mockProductsRepository.fetchAllLocations()).called(1);
      verifyNoMoreInteractions(mockProductsRepository);
    });
  });
}