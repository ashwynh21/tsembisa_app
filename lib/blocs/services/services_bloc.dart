import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa_plugin/tsembisa_plugin.dart';

part 'services_event.dart';

part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc(): super(InitialServicesState());

  @override
  Stream<ServicesState> mapEventToState(ServicesEvent event) async* {
    if(event is StartServices) {
      yield LoadingServices();

      Future.wait([
        TsembisaPlugin.geolocation.registerLocationService(),
        TsembisaPlugin.geofence.registerGeofence(),
        TsembisaPlugin.checkin.registerCheckin(),
        TsembisaPlugin.authentication.startMqttService()
      ])
      .then((value) {
        add(ServicesRunningEvent());
      })
      .catchError((error) {
        if(!(error is ApplicationException)) {
          error = ApplicationException(error.toString());
        }
        add(ServicesFailedEvent());
      });
    }

    else if (event is ServicesRunningEvent) {
      yield ServicesRunning();
    }
    else if (event is ServicesFailedEvent) {
      yield FailedServices();
    }
  }
}
