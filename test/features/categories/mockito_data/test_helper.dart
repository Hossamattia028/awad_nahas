
import 'package:awad_nahas/features/categories/data/data_sources/category_remote_data_source.dart';
import 'package:awad_nahas/features/categories/domain/repositories/category_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;



@GenerateMocks(
  [
    CategoryRepository,
    CategoryRemoteDataSource
  ],
  customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)


void main(){

}