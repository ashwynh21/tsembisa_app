part of 'exceptions.dart';

class AuthenticationException implements ApplicationException {

  final String message;

  const AuthenticationException([this.message = ""]);

  String toString() => "AuthenticationException: $message";
  String getMessage(){ return this.message;}
}