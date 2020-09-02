part of 'registration_bloc.dart';

@immutable
abstract class RegistrationState {}

class InitialRegistrationState extends RegistrationState {}

class LoadingRegistration extends RegistrationState {}
class SuccessRegistration extends RegistrationState {}
class FailedRegistration extends RegistrationState {
  final ApplicationException exception;

  FailedRegistration({@required this.exception});
}