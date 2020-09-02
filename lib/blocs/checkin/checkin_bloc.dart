import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/services/checkin/checkin.service.dart';

part 'checkin_event.dart';

part 'checkin_state.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  final CheckinService checkinservice = new CheckinService();

  CheckinBloc(): super(InitialCheckinState());

  @override
  Stream<CheckinState> mapEventToState(CheckinEvent event) async* {
    if(event is MakeCheckin) {
      /*
      * here we make sure the user has the field set and then make the submission
      * from here...*/
      yield LoadingCheckin();

      checkinservice.create(description: event.value)
      .then((value) {
        add(SubmittedCheckinEvent());
      })
      .catchError((error) {

        if(!(error is ApplicationException)) {
          error = ApplicationException(error.toString());
        }

        add(FailedCheckinEvent(exception: error));
      });
    }

    /*
    * Let us then get the other helper events down onto the event loop*/
    else if(event is SubmittedCheckinEvent) {
      yield SubmittedCheckin();
    }
    else if(event is FailedCheckinEvent) {
      yield FailedCheckin(exception: event.exception);
    }
  }
}
