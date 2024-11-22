import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  FirebaseFirestore,
  CollectionReference,
  Query,
  QuerySnapshot,
  QueryDocumentSnapshot,
  UserCredential,
])
void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockQuery<Map<String, dynamic>> mockQuery;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference<Map<String, dynamic>>();
    mockQuery = MockQuery<Map<String, dynamic>>();
  });

  group('Login Tests', () {
    test('Valid Login with Username', () async {
      final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockDocumentSnapshot =
          MockQueryDocumentSnapshot<Map<String, dynamic>>();

      when(mockDocumentSnapshot.data())
          .thenReturn({'email': 'testuser@example.com'});
      when(mockQuerySnapshot.docs).thenReturn([mockDocumentSnapshot]);

      when(mockFirestore.collection('users')).thenReturn(mockCollection);

      when(mockCollection.where('username', isEqualTo: 'testuser'))
          .thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

      when(mockAuth.signInWithEmailAndPassword(
        email: 'testuser@example.com',
        password: 'password123',
      )).thenAnswer((_) async => MockUserCredential());

      final querySnapshot = await mockFirestore
          .collection('users')
          .where('username', isEqualTo: 'testuser')
          .get();

      final userEmail = querySnapshot.docs.first.data()['email'];

      expect(userEmail, 'testuser@example.com');
      expect(
        await mockAuth.signInWithEmailAndPassword(
          email: userEmail,
          password: 'password123',
        ),
        isA<UserCredential>(),
      );
    });

    test('Login with Invalid Email', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: 'invalidemail',
        password: 'password123',
      )).thenThrow(FirebaseAuthException(code: 'invalid-email'));

      expect(
        () async => await mockAuth.signInWithEmailAndPassword(
          email: 'invalidemail',
          password: 'password123',
        ),
        throwsA(isA<FirebaseAuthException>()),
      );
    });

    test('Login with Incorrect Password', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: 'testuser@example.com',
        password: 'wrongpassword',
      )).thenThrow(FirebaseAuthException(code: 'wrong-password'));

      expect(
        () async => await mockAuth.signInWithEmailAndPassword(
          email: 'testuser@example.com',
          password: 'wrongpassword',
        ),
        throwsA(isA<FirebaseAuthException>()),
      );
    });
  });
}
