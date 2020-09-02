part of 'contacts_bloc.dart';

@immutable
abstract class ContactsEvent {}

/*Let us make an event that will allow us to create a contact trace and submit
* it through the provided API endpoint*/
class CreateContact extends ContactsEvent {
  final String number, name;

  CreateContact({@required this.name, @required this.number});
}

/*
* Let us also add in the helper events that will allow us to modify the state
* asynchronously*/
class ContactCreatedEvent extends ContactsEvent {}

class ContactCreationFailedEvent extends ContactsEvent {
  final ApplicationException exception;

  ContactCreationFailedEvent({@required this.exception});
}