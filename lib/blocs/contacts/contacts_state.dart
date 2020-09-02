part of 'contacts_bloc.dart';

@immutable
abstract class ContactsState {}

class InitialContactsState extends ContactsState {}

class LoadingContactState extends ContactsState {}

class ContactCreatedState extends ContactsState {}

class ContactCreationFailedState extends ContactsState {
  final ApplicationException exception;

  ContactCreationFailedState({@required this.exception});
}