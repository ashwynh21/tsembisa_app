part of 'verification_bloc.dart';

@immutable
abstract class VerificationEvent {}

/* *
* Here we define the events or actions that will be changing the state of the
* bloc...
* */
class GetVerificationEvent extends VerificationEvent {
  final String mobile;
  final String pin;

  GetVerificationEvent({@required this.mobile, @required this.pin});
}

/*
* Let us make an event to reset the form process and take the state back to it
* initial form*/
class ResetVerificationEvent extends VerificationEvent {}

/*
* Here we add the helper events in case something happens in the mutator*/
class FinishVerificationEvent extends VerificationEvent {}

class FailedVerificationEvent extends VerificationEvent {
  final ApplicationException exception;

  FailedVerificationEvent({@required this.exception});
}