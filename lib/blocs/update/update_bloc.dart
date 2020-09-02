import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/services/user/user.service.dart';
import 'package:tsembisa/configurations/environment.dart' as environment;

part 'update_event.dart';

part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final UserService userservice = new UserService();

  UpdateBloc() : super(InitialUpdateState());

  @override
  Stream<UpdateState> mapEventToState(UpdateEvent event) async* {
    if(event is CheckUpdate) {
      int version = await userservice.checkupdates();

      if((environment.version != version)) {
        yield TriggerUpdate(update: version);
      }
    }
  }
}
