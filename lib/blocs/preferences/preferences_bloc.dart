import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa_plugin/models/user.model.dart';
import 'package:tsembisa_plugin/tsembisa_plugin.dart';

part 'preferences_event.dart';

part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {

  PreferencesBloc() : super(InitialPreferencesState());

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if(event is CheckPreferences) {
      yield LoadingPreferences();

      UserModel user = await TsembisaPlugin.authentication.getUser();

      if(user != null)
        yield FoundPreferences(user: user);
      else
        yield NoPreferences();
    }
  }
}
