
import 'package:awad_nahas/features/authentication/domain/repositories/auth_service_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;



@GenerateMocks(
  [
    AuthServiceRepository
  ],
  customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)


void main(){

}