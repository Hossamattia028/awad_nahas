import 'package:awad_nahas/features/locations/data/data_sources/location_remote_data_source.dart';
import 'package:awad_nahas/features/locations/domain/repositories/location_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;


@GenerateMocks(
  [
    LocationsRepository,
    LocationRemoteDataSource
  ],
  customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)



void main(){

}