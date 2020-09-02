part of 'checkin_bloc.dart';

@immutable
abstract class CheckinEvent {}

/*
* We are going to need an event to create a checkin instance through the service
* of the application*/
class MakeCheckin extends CheckinEvent {
  final int value;

  MakeCheckin({@required this.value});
}

/*
* Here let us put the helper events of the other functionality that we will
* have to use on the application submission*/
class FailedCheckinEvent extends CheckinEvent {
  final ApplicationException exception;

  FailedCheckinEvent({@required this.exception});
}
class SubmittedCheckinEvent extends CheckinEvent {}