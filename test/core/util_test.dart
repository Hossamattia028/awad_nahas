import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main(){
  group('Global Function Tests', () {
    test('Get Location Details', () async {
      final result = await Util.getAndSaveLocationDetails(const LatLng(29.5732055, 39.1104406));

      // Assert that the result is not null
      expect(result, isNotNull);

      // Assert that the result is of type ProductResponseModel
      expect(result, isA<Placemark>());
    });

  });
}