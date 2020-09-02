part of 'exceptions.dart';

class ValidationException implements ApplicationException {

  final String message;

  const ValidationException([this.message = ""]);

  String toString() => "ValidationException: $message";
  String getMessage(){ return this.message;}
}