
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/locations/data/data_sources/location_remote_data_source.dart';
import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import '../../mockito_data/test_helper.mocks.dart';

void main(){
  late MockHttpClient mockHttpClient;
  late LocationRemoteDataSourceImpl locationRemoteDataSourceImpl;


  setUp(() {
    mockHttpClient = MockHttpClient();
    locationRemoteDataSourceImpl = LocationRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("Locations", () {

    test("get all locations", () async{
      when(
          mockHttpClient.get(Uri.parse(ApiUrl.FETCH_ADDRESS),headers: {
            'Content-Type': 'application/json',
            'ID': '4410', /// 4410 is [user_id]
          }))
      .thenAnswer((_) async => http.Response(
          fixture('locations_list_response_example.json').trim(),
          200
      ));

      //act
      final result = await locationRemoteDataSourceImpl.fetchAllLocations();

      //assert
      expect(result, isA<ProductResponseModel>());

    });
    //
    // test("get all locations failed with status error 404 or other ", () async{
    //   when(
    //       mockHttpClient.get(Uri.parse('${ApiUrl.PRODUCTS_URL}/2'),))
    //       .thenAnswer((_) async => http.Response(
    //        "Not found",
    //        404
    //   ));
    //
    //   // act and assert
    //   expect(() async {
    //     await locationRemoteDataSourceImpl.fetchAllLocations();
    //   }, throwsA(isA<ServerException>()));
    //
    // });

  });
  
  
}