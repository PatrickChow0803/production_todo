import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_to_do/services/auth.dart';

// Because authStateChanges() returns a User, create a MockUser class
class MockUser extends Mock implements User {}

// Because MockUser() == MockUser() equals null, create this variable
final MockUser _mockUser = MockUser();

// We're mocking the FirebaseAuth class and MockAuth will contain all of the mocks
class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);

  // setUp runs before every single test
  setUp(() {});

  // tearDown runs after every single test
  tearDown(() {});

  // Test to see if authStateChanges() actually work
  test('emit occurs', () async {
    // Used for anything that expects futures
    expectLater(auth.user, emitsInOrder([_mockUser]));
  });

  // Test to see if createUserWithEmailAndPassword() actually work
  test('create account', () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'patrick123@gmail.com', password: '123456'),
    ).thenAnswer((realInvocation) => null);
    expect(
      await auth.createAccount(email: 'patrick123@gmail.com', password: '123465'),
      'Success',
    );
  });

  // Test to see if FirebaseAuthException works or not
  test('create account exception', () async {
    when(
      mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'patrick123@gmail.com', password: '123456'),
    ).thenAnswer((realInvocation) => throw FirebaseAuthException(message: 'You messed up'));
    expect(
      await auth.createAccount(email: 'patrick123@gmail.com', password: '123465'),
      'You messed up',
    );
  });
}
