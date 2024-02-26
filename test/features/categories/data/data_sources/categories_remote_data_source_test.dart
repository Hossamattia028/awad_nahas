
import 'package:awad_nahas/core/error/exception.dart';
import 'package:awad_nahas/core/strings/api/api_url.dart';
import 'package:awad_nahas/features/categories/data/data_sources/category_remote_data_source.dart';
import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import '../../mockito_data/test_helper.mocks.dart';

void main(){
  late MockHttpClient mockHttpClient;
  late CategoryRemoteDataSourceImpl categoryRemoteDataSourceImpl;


  setUp(() {
    mockHttpClient = MockHttpClient();
    categoryRemoteDataSourceImpl = CategoryRemoteDataSourceImpl(client: mockHttpClient);
  });

  group("Categories", () {
    test("get all categories", () async{
      when(
          mockHttpClient.get(Uri.parse(ApiUrl.CATEGORIES_URL),))
      .thenAnswer((_) async => http.Response(
          fixture('category_list_example.json').trim(),
          200
      ));

      //act
      final result = await categoryRemoteDataSourceImpl.getAllCategory();

      //assert
      expect(result, isA<List<CategoriesModel>>());
    });

    test("get all categories failed with status error 404 or other", () async{
      when(
          mockHttpClient.get(Uri.parse(ApiUrl.CATEGORIES_URL),))
          .thenAnswer((_) async => http.Response(
           "Not found",
           404
      ));

      // act and assert
      expect(() async {
        await categoryRemoteDataSourceImpl.getAllCategory();
      }, throwsA(isA<ServerException>()));

    });

  });
  
  
}