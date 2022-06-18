part of 'authentication_service.dart';

/// An interface for AuthenticationService
abstract class IAuthenticationService{ 
  /// A description for authenticateUser
  FutureOr<String> authenticateUser();
  
  /// A description for logOut
  FutureOr<String> logOut();
  
}
