part of 'checkin_bloc.dart';

@immutable
abstract class CheckinState {}

class InitialCheckinState extends CheckinState {}

/*
* For submitting the checkin report we will need to make some states to
* represent the progress of the state event...we will probably also need some
* helper events to progress the asynchronous events of the applcation...*/
class LoadingCheckin extends CheckinState {}

class FailedCheckin extends CheckinState {
  final ApplicationException exception;

  FailedCheckin({@required this.exception});
}
class SubmittedCheckin extends CheckinState {}