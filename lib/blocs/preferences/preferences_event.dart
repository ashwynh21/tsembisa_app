part of 'preferences_bloc.dart';

@immutable
abstract class PreferencesEvent {}

/*
* We should only be checking for one event at this point, that is if the user
* has data stored onto the plugin storage...
* */
class CheckPreferences extends PreferencesEvent {}