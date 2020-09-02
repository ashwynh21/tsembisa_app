/*
Here we will be describing a frame in which the rest of our services will be
extending their functionality.

The base service should come with a few base services that need to be considered
i.  the service should have an optional storage point instance provided to it.
ii. it should have base http request functionality as well as http error
    handling
iii.the service should also have a generic template used in order for the
    extended service to be able to operate its model and data store.
    this way services that extend the base service will have to provide the model
    as the interface and define a set of functions in its self to operate on the
    model structure.
 */
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import 'package:tsembisa/configurations/environment.dart' as environment;
import 'package:tsembisa_plugin/models/user.model.dart';
import 'package:tsembisa_plugin/tsembisa_plugin.dart';

abstract class Service<T> {
  /*
  The name field will be a helper in determining the route path for the network
  aspect of the service.
   */
  Future<Box<T>> storage;
  Future<UserModel> shared;

  String name;
  /*
  We define the global storage point as a shared preference here. we define
  it as a user model since it is not expected to change.

  we are going to have to make the value static through the lifetime of the
  application because now its becoming a problem. it is not desired to have
  to many static values because of the memory overhead that static values can
  cause on the performance of an application.
   */

  Service({
    @required this.name,
    TypeAdapter<T> adapter
  }) {
    /*
    Now we register the shared preferences adapter using the user model adapter
     */
    try {
      shared = TsembisaPlugin.authentication.getUser();
    } catch (e) {
      print(e);
    }

    /*
    so now we need to make sure that when the service is used we devise a way to
    ensure that a request is made on its behalf. So now the idea is that we
    define the functions in the extended services and register them in the service
    definition and add them into the service.

    the difference between this platform and the corresponding api is that we
    need to initiate requests through the function calls.

    one way we could do it is that we could run a function that will prepare the
    function for calling during construction by modifying it with a bootstrapping
    function to the network request.
     */
    if(adapter != null) {
      try {
        Hive.registerAdapter<T>(adapter);
      } catch(e) {
        print(e);
      }
    }

    storage = Hive.openBox<T>(name);
  }

  /*
  This function is adapted from the old application and will serve this application
  as a base request for http.
   */
  Future<dynamic> request(Map<String, dynamic> data, {
    String route,
    String method,
    int timeout = environment.timeout,
  }) {
    /*
    Here we evaluate the function or method call appropriately
     */
    dynamic Function(http.Response) call = (http.Response response) {
      switch(response.statusCode) {
        /*
        These are the status codes that should be accepted by the application
         */
        case 201:
        case 200:
          /*
          lets try decode the response since we will have binding issues from
          using the main class response system...
           */
          return jsonDecode(response.body);

          break;
        case 422:
        case 404:
          throw ConnectionException(response.body);
        case 401:
          throw AuthenticationException(response.body);
        default:
          throw ConnectionException(response.body);
      }
    };

    /*
    now we should try and catch the error by having a try catch block around the
    request function call. this will prevent the unusual behavior.
     */
    if(method == 'put'){
      return http.put(route,
          body: data..removeWhere((key, value) => value == null)
      )
        .timeout(Duration(seconds: environment.timeout), onTimeout: () => throw TimeoutException('Oops, request has timed out!'))
        .then(call);
    }
    else if(method == 'get') {
      return http.get(route,
      )
        .timeout(Duration(seconds: environment.timeout), onTimeout: () => throw TimeoutException('Oops, request has timed out!'))
        .then(call);
    }
    else if(method == 'delete') {
      return http.delete(route,
      )
        .timeout(Duration(seconds: environment.timeout), onTimeout: () => throw TimeoutException('Oops, request has timed out!'))
        .then(call);
    }
    else
      return http.post(route,
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode(data..removeWhere((key, value) => value == null,))
      )
        .timeout(Duration(seconds: environment.timeout), onTimeout: () => throw TimeoutException('Oops, request has timed out!'))
        .then(call);
  }

  /*
  we now need to make a request function that will allow me to be able to get
  feedback on the progress of a request.
   */
  Future<http.StreamedResponse> stream(Map<String, String> data, {
    String route,
    int timeout = environment.timeout,
  }) {
    /*
    since we want a stream from this function we need to create a stream
     */
    final client = new http.Client();

    /*
    we could make or create a limitation so that this function only works with
    get request methods

     */
    return client.send(http.Request('get', Uri.parse(environment.host + route)));
  }

  /*
  * lets now make a function that will get and set the shared preferences
  * that we have made here...
  * */
  Future<void> setshared(UserModel user) => this.shared.then((value) {
    return TsembisaPlugin.authentication.saveUser(user);
  });
  Future<UserModel> getshared() => this.shared.then((value) => TsembisaPlugin.authentication.getUser());
}

/*
let us create an interface for a service to allow the configuration structures to
enable dynamic requesting from the system. with this we will thus use a map
structure to get this to work.

So now we can make the storage call for the shared user information when the
user access service is called for an access token. This will thus create a
dependency between these two classes so to fix that we can create a separated
call function for access.
 */
class ServiceInterface<T> {
  String route;
  Future Function(T) callback;
  /*
  This field will indicate whether the request will require authentication from the
  application in which it will send the access call for a token.
   */
  bool authentication;
}