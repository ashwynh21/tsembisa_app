part of 'preferences_bloc.dart';

@immutable
abstract class PreferencesState {}

class InitialPreferencesState extends PreferencesState {}

class LoadingPreferences extends PreferencesState {}

class FoundPreferences extends PreferencesState {
  final UserModel user;

  FoundPreferences({@required this.user});
}

class NoPreferences extends PreferencesState {}