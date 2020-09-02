part of 'exceptions.dart';

class UnknownException implements ApplicationException {

  final String message;

  const UnknownException([this.message = ""]);

  String toString() => "UnknownException: $message";
  String getMessage(){ return this.message;}
}