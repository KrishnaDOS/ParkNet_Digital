// Mocks generated by Mockito 5.4.4 from annotations
// in parkgsu/test/fetch_nearest_parking_deck.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i10;

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart'
    as _i4;
import 'package:firebase_core/firebase_core.dart' as _i3;
import 'package:geolocator_platform_interface/src/enums/enums.dart' as _i8;
import 'package:geolocator_platform_interface/src/geolocator_platform_interface.dart'
    as _i7;
import 'package:geolocator_platform_interface/src/models/models.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePosition_0 extends _i1.SmartFake implements _i2.Position {
  _FakePosition_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFirebaseApp_1 extends _i1.SmartFake implements _i3.FirebaseApp {
  _FakeFirebaseApp_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSettings_2 extends _i1.SmartFake implements _i4.Settings {
  _FakeSettings_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCollectionReference_3<T extends Object?> extends _i1.SmartFake
    implements _i5.CollectionReference<T> {
  _FakeCollectionReference_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWriteBatch_4 extends _i1.SmartFake implements _i5.WriteBatch {
  _FakeWriteBatch_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoadBundleTask_5 extends _i1.SmartFake
    implements _i5.LoadBundleTask {
  _FakeLoadBundleTask_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeQuerySnapshot_6<T1 extends Object?> extends _i1.SmartFake
    implements _i5.QuerySnapshot<T1> {
  _FakeQuerySnapshot_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeQuery_7<T extends Object?> extends _i1.SmartFake
    implements _i5.Query<T> {
  _FakeQuery_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDocumentReference_8<T extends Object?> extends _i1.SmartFake
    implements _i5.DocumentReference<T> {
  _FakeDocumentReference_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_9<T1> extends _i1.SmartFake implements _i6.Future<T1> {
  _FakeFuture_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSnapshotMetadata_10 extends _i1.SmartFake
    implements _i5.SnapshotMetadata {
  _FakeSnapshotMetadata_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GeolocatorPlatform].
///
/// See the documentation for Mockito's code generation for more information.
class MockGeolocatorPlatform extends _i1.Mock
    implements _i7.GeolocatorPlatform {
  MockGeolocatorPlatform() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i8.LocationPermission> checkPermission() => (super.noSuchMethod(
        Invocation.method(
          #checkPermission,
          [],
        ),
        returnValue: _i6.Future<_i8.LocationPermission>.value(
            _i8.LocationPermission.denied),
      ) as _i6.Future<_i8.LocationPermission>);

  @override
  _i6.Future<_i8.LocationPermission> requestPermission() => (super.noSuchMethod(
        Invocation.method(
          #requestPermission,
          [],
        ),
        returnValue: _i6.Future<_i8.LocationPermission>.value(
            _i8.LocationPermission.denied),
      ) as _i6.Future<_i8.LocationPermission>);

  @override
  _i6.Future<bool> isLocationServiceEnabled() => (super.noSuchMethod(
        Invocation.method(
          #isLocationServiceEnabled,
          [],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<_i2.Position?> getLastKnownPosition(
          {bool? forceLocationManager = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getLastKnownPosition,
          [],
          {#forceLocationManager: forceLocationManager},
        ),
        returnValue: _i6.Future<_i2.Position?>.value(),
      ) as _i6.Future<_i2.Position?>);

  @override
  _i6.Future<_i2.Position> getCurrentPosition(
          {_i2.LocationSettings? locationSettings}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentPosition,
          [],
          {#locationSettings: locationSettings},
        ),
        returnValue: _i6.Future<_i2.Position>.value(_FakePosition_0(
          this,
          Invocation.method(
            #getCurrentPosition,
            [],
            {#locationSettings: locationSettings},
          ),
        )),
      ) as _i6.Future<_i2.Position>);

  @override
  _i6.Stream<_i8.ServiceStatus> getServiceStatusStream() => (super.noSuchMethod(
        Invocation.method(
          #getServiceStatusStream,
          [],
        ),
        returnValue: _i6.Stream<_i8.ServiceStatus>.empty(),
      ) as _i6.Stream<_i8.ServiceStatus>);

  @override
  _i6.Stream<_i2.Position> getPositionStream(
          {_i2.LocationSettings? locationSettings}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPositionStream,
          [],
          {#locationSettings: locationSettings},
        ),
        returnValue: _i6.Stream<_i2.Position>.empty(),
      ) as _i6.Stream<_i2.Position>);

  @override
  _i6.Future<_i8.LocationAccuracyStatus> requestTemporaryFullAccuracy(
          {required String? purposeKey}) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestTemporaryFullAccuracy,
          [],
          {#purposeKey: purposeKey},
        ),
        returnValue: _i6.Future<_i8.LocationAccuracyStatus>.value(
            _i8.LocationAccuracyStatus.reduced),
      ) as _i6.Future<_i8.LocationAccuracyStatus>);

  @override
  _i6.Future<_i8.LocationAccuracyStatus> getLocationAccuracy() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLocationAccuracy,
          [],
        ),
        returnValue: _i6.Future<_i8.LocationAccuracyStatus>.value(
            _i8.LocationAccuracyStatus.reduced),
      ) as _i6.Future<_i8.LocationAccuracyStatus>);

  @override
  _i6.Future<bool> openAppSettings() => (super.noSuchMethod(
        Invocation.method(
          #openAppSettings,
          [],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  _i6.Future<bool> openLocationSettings() => (super.noSuchMethod(
        Invocation.method(
          #openLocationSettings,
          [],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);

  @override
  double distanceBetween(
    double? startLatitude,
    double? startLongitude,
    double? endLatitude,
    double? endLongitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #distanceBetween,
          [
            startLatitude,
            startLongitude,
            endLatitude,
            endLongitude,
          ],
        ),
        returnValue: 0.0,
      ) as double);

  @override
  double bearingBetween(
    double? startLatitude,
    double? startLongitude,
    double? endLatitude,
    double? endLongitude,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #bearingBetween,
          [
            startLatitude,
            startLongitude,
            endLatitude,
            endLongitude,
          ],
        ),
        returnValue: 0.0,
      ) as double);
}

/// A class which mocks [FirebaseFirestore].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseFirestore extends _i1.Mock implements _i5.FirebaseFirestore {
  MockFirebaseFirestore() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.FirebaseApp get app => (super.noSuchMethod(
        Invocation.getter(#app),
        returnValue: _FakeFirebaseApp_1(
          this,
          Invocation.getter(#app),
        ),
      ) as _i3.FirebaseApp);

  @override
  set app(_i3.FirebaseApp? _app) => super.noSuchMethod(
        Invocation.setter(
          #app,
          _app,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get databaseURL => (super.noSuchMethod(
        Invocation.getter(#databaseURL),
        returnValue: _i9.dummyValue<String>(
          this,
          Invocation.getter(#databaseURL),
        ),
      ) as String);

  @override
  set databaseURL(String? _databaseURL) => super.noSuchMethod(
        Invocation.setter(
          #databaseURL,
          _databaseURL,
        ),
        returnValueForMissingStub: null,
      );

  @override
  String get databaseId => (super.noSuchMethod(
        Invocation.getter(#databaseId),
        returnValue: _i9.dummyValue<String>(
          this,
          Invocation.getter(#databaseId),
        ),
      ) as String);

  @override
  set databaseId(String? _databaseId) => super.noSuchMethod(
        Invocation.setter(
          #databaseId,
          _databaseId,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set settings(_i4.Settings? settings) => super.noSuchMethod(
        Invocation.setter(
          #settings,
          settings,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Settings get settings => (super.noSuchMethod(
        Invocation.getter(#settings),
        returnValue: _FakeSettings_2(
          this,
          Invocation.getter(#settings),
        ),
      ) as _i4.Settings);

  @override
  Map<dynamic, dynamic> get pluginConstants => (super.noSuchMethod(
        Invocation.getter(#pluginConstants),
        returnValue: <dynamic, dynamic>{},
      ) as Map<dynamic, dynamic>);

  @override
  _i5.CollectionReference<Map<String, dynamic>> collection(
          String? collectionPath) =>
      (super.noSuchMethod(
        Invocation.method(
          #collection,
          [collectionPath],
        ),
        returnValue: _FakeCollectionReference_3<Map<String, dynamic>>(
          this,
          Invocation.method(
            #collection,
            [collectionPath],
          ),
        ),
      ) as _i5.CollectionReference<Map<String, dynamic>>);

  @override
  _i5.WriteBatch batch() => (super.noSuchMethod(
        Invocation.method(
          #batch,
          [],
        ),
        returnValue: _FakeWriteBatch_4(
          this,
          Invocation.method(
            #batch,
            [],
          ),
        ),
      ) as _i5.WriteBatch);

  @override
  _i6.Future<void> clearPersistence() => (super.noSuchMethod(
        Invocation.method(
          #clearPersistence,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> enablePersistence(
          [_i4.PersistenceSettings? persistenceSettings]) =>
      (super.noSuchMethod(
        Invocation.method(
          #enablePersistence,
          [persistenceSettings],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i5.LoadBundleTask loadBundle(_i10.Uint8List? bundle) => (super.noSuchMethod(
        Invocation.method(
          #loadBundle,
          [bundle],
        ),
        returnValue: _FakeLoadBundleTask_5(
          this,
          Invocation.method(
            #loadBundle,
            [bundle],
          ),
        ),
      ) as _i5.LoadBundleTask);

  @override
  void useFirestoreEmulator(
    String? host,
    int? port, {
    bool? sslEnabled = false,
    bool? automaticHostMapping = true,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #useFirestoreEmulator,
          [
            host,
            port,
          ],
          {
            #sslEnabled: sslEnabled,
            #automaticHostMapping: automaticHostMapping,
          },
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<_i5.QuerySnapshot<T>> namedQueryWithConverterGet<T>(
    String? name, {
    _i4.GetOptions? options = const _i4.GetOptions(),
    required _i5.FromFirestore<T>? fromFirestore,
    required _i5.ToFirestore<T>? toFirestore,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #namedQueryWithConverterGet,
          [name],
          {
            #options: options,
            #fromFirestore: fromFirestore,
            #toFirestore: toFirestore,
          },
        ),
        returnValue:
            _i6.Future<_i5.QuerySnapshot<T>>.value(_FakeQuerySnapshot_6<T>(
          this,
          Invocation.method(
            #namedQueryWithConverterGet,
            [name],
            {
              #options: options,
              #fromFirestore: fromFirestore,
              #toFirestore: toFirestore,
            },
          ),
        )),
      ) as _i6.Future<_i5.QuerySnapshot<T>>);

  @override
  _i6.Future<_i5.QuerySnapshot<Map<String, dynamic>>> namedQueryGet(
    String? name, {
    _i4.GetOptions? options = const _i4.GetOptions(),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #namedQueryGet,
          [name],
          {#options: options},
        ),
        returnValue: _i6.Future<_i5.QuerySnapshot<Map<String, dynamic>>>.value(
            _FakeQuerySnapshot_6<Map<String, dynamic>>(
          this,
          Invocation.method(
            #namedQueryGet,
            [name],
            {#options: options},
          ),
        )),
      ) as _i6.Future<_i5.QuerySnapshot<Map<String, dynamic>>>);

  @override
  _i5.Query<Map<String, dynamic>> collectionGroup(String? collectionPath) =>
      (super.noSuchMethod(
        Invocation.method(
          #collectionGroup,
          [collectionPath],
        ),
        returnValue: _FakeQuery_7<Map<String, dynamic>>(
          this,
          Invocation.method(
            #collectionGroup,
            [collectionPath],
          ),
        ),
      ) as _i5.Query<Map<String, dynamic>>);

  @override
  _i6.Future<void> disableNetwork() => (super.noSuchMethod(
        Invocation.method(
          #disableNetwork,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i5.DocumentReference<Map<String, dynamic>> doc(String? documentPath) =>
      (super.noSuchMethod(
        Invocation.method(
          #doc,
          [documentPath],
        ),
        returnValue: _FakeDocumentReference_8<Map<String, dynamic>>(
          this,
          Invocation.method(
            #doc,
            [documentPath],
          ),
        ),
      ) as _i5.DocumentReference<Map<String, dynamic>>);

  @override
  _i6.Future<void> enableNetwork() => (super.noSuchMethod(
        Invocation.method(
          #enableNetwork,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Stream<void> snapshotsInSync() => (super.noSuchMethod(
        Invocation.method(
          #snapshotsInSync,
          [],
        ),
        returnValue: _i6.Stream<void>.empty(),
      ) as _i6.Stream<void>);

  @override
  _i6.Future<T> runTransaction<T>(
    _i5.TransactionHandler<T>? transactionHandler, {
    Duration? timeout = const Duration(seconds: 30),
    int? maxAttempts = 5,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #runTransaction,
          [transactionHandler],
          {
            #timeout: timeout,
            #maxAttempts: maxAttempts,
          },
        ),
        returnValue: _i9.ifNotNull(
              _i9.dummyValueOrNull<T>(
                this,
                Invocation.method(
                  #runTransaction,
                  [transactionHandler],
                  {
                    #timeout: timeout,
                    #maxAttempts: maxAttempts,
                  },
                ),
              ),
              (T v) => _i6.Future<T>.value(v),
            ) ??
            _FakeFuture_9<T>(
              this,
              Invocation.method(
                #runTransaction,
                [transactionHandler],
                {
                  #timeout: timeout,
                  #maxAttempts: maxAttempts,
                },
              ),
            ),
      ) as _i6.Future<T>);

  @override
  _i6.Future<void> terminate() => (super.noSuchMethod(
        Invocation.method(
          #terminate,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> waitForPendingWrites() => (super.noSuchMethod(
        Invocation.method(
          #waitForPendingWrites,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> setIndexConfiguration({
    required List<_i4.Index>? indexes,
    List<_i4.FieldOverrides>? fieldOverrides,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setIndexConfiguration,
          [],
          {
            #indexes: indexes,
            #fieldOverrides: fieldOverrides,
          },
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> setIndexConfigurationFromJSON(String? json) =>
      (super.noSuchMethod(
        Invocation.method(
          #setIndexConfigurationFromJSON,
          [json],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
}

/// A class which mocks [QuerySnapshot].
///
/// See the documentation for Mockito's code generation for more information.
class MockQuerySnapshot<T extends Object?> extends _i1.Mock
    implements _i5.QuerySnapshot<T> {
  MockQuerySnapshot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i5.QueryDocumentSnapshot<T>> get docs => (super.noSuchMethod(
        Invocation.getter(#docs),
        returnValue: <_i5.QueryDocumentSnapshot<T>>[],
      ) as List<_i5.QueryDocumentSnapshot<T>>);

  @override
  List<_i5.DocumentChange<T>> get docChanges => (super.noSuchMethod(
        Invocation.getter(#docChanges),
        returnValue: <_i5.DocumentChange<T>>[],
      ) as List<_i5.DocumentChange<T>>);

  @override
  _i5.SnapshotMetadata get metadata => (super.noSuchMethod(
        Invocation.getter(#metadata),
        returnValue: _FakeSnapshotMetadata_10(
          this,
          Invocation.getter(#metadata),
        ),
      ) as _i5.SnapshotMetadata);

  @override
  int get size => (super.noSuchMethod(
        Invocation.getter(#size),
        returnValue: 0,
      ) as int);
}

/// A class which mocks [QueryDocumentSnapshot].
///
/// See the documentation for Mockito's code generation for more information.
class MockQueryDocumentSnapshot<T extends Object?> extends _i1.Mock
    implements _i5.QueryDocumentSnapshot<T> {
  MockQueryDocumentSnapshot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: _i9.dummyValue<String>(
          this,
          Invocation.getter(#id),
        ),
      ) as String);

  @override
  _i5.DocumentReference<T> get reference => (super.noSuchMethod(
        Invocation.getter(#reference),
        returnValue: _FakeDocumentReference_8<T>(
          this,
          Invocation.getter(#reference),
        ),
      ) as _i5.DocumentReference<T>);

  @override
  _i5.SnapshotMetadata get metadata => (super.noSuchMethod(
        Invocation.getter(#metadata),
        returnValue: _FakeSnapshotMetadata_10(
          this,
          Invocation.getter(#metadata),
        ),
      ) as _i5.SnapshotMetadata);

  @override
  bool get exists => (super.noSuchMethod(
        Invocation.getter(#exists),
        returnValue: false,
      ) as bool);

  @override
  T data() => (super.noSuchMethod(
        Invocation.method(
          #data,
          [],
        ),
        returnValue: _i9.dummyValue<T>(
          this,
          Invocation.method(
            #data,
            [],
          ),
        ),
      ) as T);

  @override
  dynamic get(Object? field) => super.noSuchMethod(Invocation.method(
        #get,
        [field],
      ));

  @override
  dynamic operator [](Object? field) => super.noSuchMethod(Invocation.method(
        #[],
        [field],
      ));
}
