import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'gps_permissions_test.mocks.dart';

@GenerateMocks([GeolocatorPlatform])
void main() {
  late MockGeolocatorPlatform mockGeolocator;

  setUp(() {
    mockGeolocator = MockGeolocatorPlatform();
  });

  group('GPS Permission Tests', () {
    test('Verify GPS Permissions are granted', () async {
      when(mockGeolocator.checkPermission()).thenAnswer(
        (_) async => LocationPermission.whileInUse,
      );

      LocationPermission permission = await mockGeolocator.checkPermission();

      expect(permission, isNot(LocationPermission.denied));
    });

    test('Request permission if GPS permission is denied', () async {
      when(mockGeolocator.checkPermission()).thenAnswer(
        (_) async => LocationPermission.denied,
      );

      when(mockGeolocator.requestPermission()).thenAnswer(
        (_) async => LocationPermission.whileInUse,
      );

      LocationPermission permission = await mockGeolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await mockGeolocator.requestPermission();
      }

      expect(permission, LocationPermission.whileInUse);
    });
  });
}
