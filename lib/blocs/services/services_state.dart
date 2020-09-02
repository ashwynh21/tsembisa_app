part of 'services_bloc.dart';

@immutable
abstract class ServicesState {}

class InitialServicesState extends ServicesState {}

class LoadingServices extends ServicesState {}
class ServicesRunning extends ServicesState {}
class FailedServices extends ServicesState {}