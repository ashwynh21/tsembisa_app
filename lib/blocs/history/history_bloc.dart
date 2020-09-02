import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/models/checkin.model.dart';
import 'package:tsembisa/screens/checkin/checkin.dart';
import 'package:tsembisa/services/checkin/checkin.service.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final CheckinService checkinservice = new CheckinService();

  HistoryBloc() : super(InitialHistoryState());

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if(event is ReadHistory) {
      yield LoadingHistory();

      checkinservice.readall()
      .then((value) {
        add(ReadHistoryEvent(history: value));
      })
      .catchError((error) {
        add(FailedHistoryEvent(exception: error));
      });
    }

    /*
    * Lets add the helper events here*/
    else if(event is ReadHistoryEvent) {
      yield SuccessHistory(history: event.history.reversed.toList());
    }
    else if(event is FailedHistoryEvent) {
      yield FailedHistory(exception: event.exception);
    }
  }
}
