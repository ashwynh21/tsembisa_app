import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/blocs/history/history_bloc.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/helpers/validation.dart';
import 'package:tsembisa/services/contact/contact.service.dart';

part 'contacts_event.dart';

part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactService contactservice = new ContactService();

  ContactsBloc() : super(InitialContactsState());

  @override
  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if(event is CreateContact) {
      yield LoadingContactState();

      if(isNumber(event.number) && event.name != null) {
        contactservice.create(fullname: event.name, mobile: event.number)
        .then((value) {
          add(ContactCreatedEvent());
        })
        .catchError((error) {

          if(!(error is ApplicationException)) {
            error = ApplicationException(error.toString());
          }

          add(ContactCreationFailedEvent(exception: error));
        });
      } else {
        add(ContactCreationFailedEvent(exception: ApplicationException('Oops, something wrong with the name or number!')));
      }
    }

    else if(event is ContactCreatedEvent) {
      yield ContactCreatedState();
    }
    else if(event is ContactCreationFailedEvent) {
      yield ContactCreationFailedState(exception: event.exception);
    }
  }
}
