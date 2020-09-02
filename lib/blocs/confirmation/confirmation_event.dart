part of 'confirmation_bloc.dart';

@immutable
abstract class ConfirmationEvent {}
/*
* Okay, here we require a class event to trigger the start of the confirmation
* process
* */

class GetConfirmationEvent extends ConfirmationEvent {
  final String mobile, otp;

  GetConfirmationEvent({
    @required this.mobile,
    @required this.otp
  });
}
/*
* Here let us add in the helper class events
* */
class FinishConfirmationEvent extends ConfirmationEvent {}

class FailedConfirmationEvent extends ConfirmationEvent {
  final ApplicationException exception;

  FailedConfirmationEvent({@required this.exception});
}