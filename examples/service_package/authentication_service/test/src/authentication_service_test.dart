import 'package:authentication_service/authentication_service.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationService', () {
    late AuthenticationService authenticationService;

    setUp(() {
      authenticationService = const AuthenticationService();
    });

    test('can be instantiated', () {
      expect(const AuthenticationService(), isNotNull);
    });
    
    group('authenticateUser', () {
      test('executes happy flow', () async {
        final someValue = authenticationService.authenticateUser();
        //expect(someValue, equals(someValue));
      });

      test('executes edge flow', () async {
        final someValue = authenticationService.authenticateUser();
        //expect(someValue, equals(someValue));
      });
    });
    
    group('logOut', () {
      test('executes happy flow', () async {
        final someValue = authenticationService.logOut();
        //expect(someValue, equals(someValue));
      });

      test('executes edge flow', () async {
        final someValue = authenticationService.logOut();
        //expect(someValue, equals(someValue));
      });
    });
    
  });
}
