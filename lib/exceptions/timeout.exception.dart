part of 'exceptions.dart';

class TimeoutException implements ApplicationException {

  final String message;

  const TimeoutException([this.message = ""]);

  String toString() => "TimeoutException: $message";
  String getMessage(){ return this.message;}
}