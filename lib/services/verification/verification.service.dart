

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tsembisa/declarations/service.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa_plugin/models/user.model.dart';

class VerificationService extends Service<Map> {

  VerificationService() : super(name: 'verification');

  Future<UserModel> sms({
    @required String mobile,
  }) async {
    return super.request({},
      route: 'http://ndma-web.realnet.co.sz:5000/gotp?cell_number=$mobile&method=sms',
      method: 'get',
    ).then((payload) {
      /*
      This payload will then be the user model with the token in so now,
      we have to store it.
       */
      return shared;
    });
  }

  Future<UserModel> confirm({
    @required String mobile,
    @required String otp
  }) async {

    return super.request({},
      route: 'http://ndma-web.realnet.co.sz:5000/confirm?cell_number=$mobile&otp=$otp',
      method: 'get',
    ).then((payload) async {

      if(payload['status'] == 'SUCCESS') {
        /*
      the result will be a payload containing a mobile number
      so all we have to do now is update the user with the mobile
      number
       */
        UserModel result = UserModel.fromJson({
          'mobile': mobile
        });
        return result;
      }
      throw ConnectionException(payload['status'].toString().toLowerCase().replaceAll('_', ' '));
    });
  }
}