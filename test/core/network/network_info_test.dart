import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:github_repository_explorer/core/network/network_info.dart';

@GenerateMocks([Connectivity])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('NetworkInfo', () {
    test('should forward the call to Connectivity.checkConnectivity', () async {
      // arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // act
      await networkInfo.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity());
    });

    test('should return true when connected to WiFi', () async {
      // arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, true);
    });

    test('should return true when connected to mobile data', () async {
      // arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.mobile]);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, true);
    });

    test('should return true when connected to ethernet', () async {
      // arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.ethernet]);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, true);
    });

    test('should return false when not connected', () async {
      // arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, false);
    });

    test('should return true when multiple connections are available', () async {
      // arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi, ConnectivityResult.mobile]);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, true);
    });

    test('should return false when only none connection is available among multiple', () async {
      // arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);

      // act
      final result = await networkInfo.isConnected;

      // assert
      expect(result, false);
    });
  });
}