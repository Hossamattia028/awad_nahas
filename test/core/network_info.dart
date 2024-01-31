import 'package:awad_nahas/core/network/network.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {
  @override
  Future<bool> isConnected() {
    return super.noSuchMethod(
      Invocation.method(#isConnected, []),
      returnValue: Future.value(true),  /// this success case if return the boolean value
      // returnValue: Future.value("false"), /// this failure case if return null or string or any other values
    );
  }
}

class MockNetworkInfoImpl extends NetworkInfoImpl {
  final NetworkInfo networkInfo;

  MockNetworkInfoImpl(this.networkInfo) : super();

  @override
  Future<bool> isConnected() {
    return networkInfo.isConnected();
  }
}

void main() {
  late MockNetworkInfoImpl networkInfo;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    networkInfo = MockNetworkInfoImpl(mockNetworkInfo);
  });

  group('isConnected', () {

    test('should return bool', () async {
      // arrange
      when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      // act
      final result = await networkInfo.isConnected();
      // assert
      expect(result, true);
    });

  });
}
