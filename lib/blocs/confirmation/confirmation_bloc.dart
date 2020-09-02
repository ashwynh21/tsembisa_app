import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/helpers/validation.dart';
import 'package:tsembisa/services/verification/verification.service.dart';

part 'confirmation_event.dart';

part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final VerificationService verificationservice = new VerificationService();

  ConfirmationBloc(): super(InitialConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    if(event is GetConfirmationEvent) {
      yield LoadingConfirmation();

      if(isNumber(event.mobile) && isOTP(event.otp)) {
        verificationservice.confirm(mobile: event.mobile, otp: event.otp)
          .then((value) {
            add(FinishConfirmationEvent());
          })
          .catchError((error) {
            if(!(error is ApplicationException)) {
              error = ApplicationException(error.toString());
            }

            add(FailedConfirmationEvent(exception: error));
          });
      } else {
        yield FailedConfirmation(exception: ValidationException('Oops, either mobile number or OTP is invalid!'));
      }
    }

    else if(event is FinishConfirmationEvent) {
      yield SuccessConfirmation();
    }
    else if(event is FailedConfirmationEvent) {
      yield FailedConfirmation(exception: event.exception);
    }
  }
}
