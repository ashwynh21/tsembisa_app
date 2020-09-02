part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent {}

/*
* let us get a set of events to get the user registered to the application
* system...*/
class StartRegistrationEvent extends RegistrationEvent {
  final String mobile;
  final String pin;

  StartRegistrationEvent({
    @required this.mobile,
    @required this.pin
  });
}

/*
* We add the helper events down here*/
class SuccessRegistrationEvent extends RegistrationEvent {

}
class FailedRegistrationEvent extends RegistrationEvent {
  final ApplicationException exception;

  FailedRegistrationEvent({@required this.exception});
}