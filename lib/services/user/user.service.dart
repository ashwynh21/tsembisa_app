import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:tsembisa/declarations/service.dart';

import 'package:tsembisa/configurations/environment.dart' as environment;
import 'package:tsembisa_plugin/models/user.model.dart';

class UserService extends Service<UserModel> {
  UserService(): super(
    name: 'account',
  );
  Future<UserModel> create({
    String mobile,
    String pin
  }) async {
    var imei = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);

    return request({
      'mobile': mobile,
      'pin': pin,
      'imei': imei,
    },
      method: 'post',
      route: '${environment.host}/register.php'
    )
    .then((value) async {
      return _profile(pin)
      .then((profile) {

        UserModel user = UserModel(
          mobile: mobile,
          pin: pin,
          imei: imei,
          names: profile['FNAME'],
          surname: profile['SURNAME'],
        );

        return setshared(user)
            .then((value) => user);
      });
    });
  }

  Future<Map<String, dynamic>> _profile(String pin) async {
    return request({}, method: 'get', route: 'https://easygeni.com/getpin.php?pin=$pin')
      .then((value) {
        return value[0];
      });
  }

  Future<void> setupgeofence({
    @required double latitude,
    @required double longitude
  }) async {
    UserModel user = await shared;

    return request({
      'mobile': user.mobile,
      'latitude': latitude,
      'longitude': longitude,
      'name': 'home',
      'timestamp': DateTime.now().toIso8601String()
    }, method: 'post', route: '${environment.host}/create_klr.php').then((value) {
      print(value);

      return value;
    });
  }

  Future<int> checkupdates() {
    return request({},
        route: '${environment.host}/get_ver.php', method: 'get')
        .then((value) async {
      int version = int.parse(value['MESS']);

      return version;
    });
  }
}