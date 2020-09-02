part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class InitialHistoryState extends HistoryState {}

/*
* */
class LoadingHistory extends HistoryState {}
class SuccessHistory extends HistoryState {
  final List<CheckinModel> history;

  SuccessHistory({@required this.history});
}
class FailedHistory extends HistoryState {
  final ApplicationException exception;

  FailedHistory({@required this.exception});
}