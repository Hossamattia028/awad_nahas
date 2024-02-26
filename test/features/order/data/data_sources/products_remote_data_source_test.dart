
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:awad_nahas/features/products/data/models/products_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import '../../mockito_data/test_helper.mocks.dart';

void main(){
  late MockHttpClient mockHttpClient;
  late ProductsRemoteDataSourceImpl productsRemoteDataSourceImpl;


  setUp(() {
    mockHttpClient = MockHttpClient();
    productsRemoteDataSourceImpl = ProductsRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("Products", () {

    test("get all products", () async{
      when(
          mockHttpClient.get(Uri.parse('${ApiUrl.PRODUCTS_URL}/2'),))
      .thenAnswer((_) async => http.Response(
          fixture('product_list_example.json').trim(),
          200
      ));

      //act
      final result = await productsRemoteDataSourceImpl.getAllProducts(parameter: "2"); /// 2 is limit for pagination

      //assert
      expect(result, isA<ProductResponseModel>());

    });

    test("get all products failed with status error 404 or other ", () async{
      when(
          mockHttpClient.get(Uri.parse('${ApiUrl.PRODUCTS_URL}/2'),))
          .thenAnswer((_) async => http.Response(
           "Not found",
           404
      ));

      // act and assert
      expect(() async {
        await productsRemoteDataSourceImpl.getAllProducts(parameter: "2");
      }, throwsA(isA<ServerException>()));

    });

  });
  
  
}