part of 'exceptions.dart';

class ApplicationException implements Exception {

    final String message;

    const ApplicationException([this.message = ""]);

    String toString() => "ApplicationException: $message";
    String getMessage(){ return this.message;}
}