part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}
/*
* Here we should mainly have a single event to read the history of the user
* so that we can bring it up for display...*/
class ReadHistory extends HistoryEvent {}

class ReadHistoryEvent extends HistoryEvent {
  final List<CheckinModel> history;

  ReadHistoryEvent({@required this.history});
}
class FailedHistoryEvent extends HistoryEvent {
  final ApplicationException exception;

  FailedHistoryEvent({@required this.exception});
}