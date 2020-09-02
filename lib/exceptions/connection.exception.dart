part of 'exceptions.dart';

class ConnectionException implements ApplicationException {

    final String message;

    const ConnectionException([this.message = ""]);

    String toString() => "ConnectionException: $message";
    String getMessage(){ return this.message;}
}