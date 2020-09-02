import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/helpers/validation.dart';
import 'package:tsembisa/services/user/user.service.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserService userservice = new UserService();

  RegistrationBloc(): super(InitialRegistrationState());

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if(event is StartRegistrationEvent) {
      yield LoadingRegistration();

      if(isNumber(event.mobile) && isPIN(event.pin)) {
        userservice.create(mobile: event.mobile, pin: event.pin)
          .then((value) {
            add(SuccessRegistrationEvent());
          })
          .catchError((error) {
            if(!(error is ApplicationException)) {
              error = ApplicationException(error.toString());
            }

            add(FailedRegistrationEvent(exception: error));
          });
      } else {
        yield FailedRegistration(exception: ValidationException('Oops, either pin or mobile is invalid!'));
      }
    }

    else if(event is SuccessRegistrationEvent) {
      yield SuccessRegistration();
    }
    else if(event is FailedRegistrationEvent) {
      yield FailedRegistration(exception: event.exception);
    }
  }
}
