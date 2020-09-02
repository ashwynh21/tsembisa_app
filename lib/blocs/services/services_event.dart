part of 'services_bloc.dart';

@immutable
abstract class ServicesEvent {}
/*
* This bloc will be responsible for creating services and starting all the
* background services through the plugin that will be used by the application...
* */

class StartServices extends ServicesEvent {}

/*
* Adding helper classes down here*/
class ServicesRunningEvent extends ServicesEvent {}
class ServicesFailedEvent extends ServicesEvent {}