import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/models/trace.model.dart';
import 'package:tsembisa/services/contact/contact.service.dart';

part 'traces_event.dart';

part 'traces_state.dart';

class TracesBloc extends Bloc<TracesEvent, TracesState> {
  final ContactService contactservice = new ContactService();

  TracesBloc() : super(InitialTracesState());

  @override
  Stream<TracesState> mapEventToState(TracesEvent event) async* {
    if(event is ReadTraces) {
      yield LoadingTraces();

      contactservice.readall()
          .then((value) {
        add(FoundTraces(traces: value));
      })
          .catchError((error) {
        add(FailedTraces(exception: error));
      });
    }

    /*
    * Lets add the helper events here*/
    else if(event is FoundTraces) {
      yield FoundTracesState(traces: event.traces.reversed.toList());
    }
    else if(event is FailedTraces) {
      yield FailedTracesState(exception: event.exception);
    }
  }
}
