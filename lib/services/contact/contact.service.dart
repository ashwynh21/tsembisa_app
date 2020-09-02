

import 'package:flutter/cupertino.dart';
import 'package:tsembisa/declarations/service.dart';
import 'package:tsembisa/models/trace.model.dart';
import 'package:tsembisa_plugin/models/user.model.dart';
import 'package:tsembisa/configurations/environment.dart' as environment;

class ContactService extends Service<TraceModel> {

  ContactService() : super(
    name: 'contact',
    adapter: TraceModel.adapter
  );


  Future<TraceModel> create({
    @required String fullname,
    @required String mobile
  }) async {
    UserModel user = await shared;

    return request({
      'fullname': fullname,
      'trace': mobile,
      'mobile': user.mobile,
      'timestamp': DateTime.now().toIso8601String()
    }, route: '${environment.host}/register_contacts.php', method: 'post')
    .then((value) {
      print(value);
      TraceModel model = TraceModel.fromJson({
        'fullname': fullname,
        'mobile': mobile
      });

      return storage
      .then((box) async{
        return box.put(model.mobile, model).then((value) => model);
      });
    });
  }
  Future<List<TraceModel>> readall() {
    return storage.then((box) {
      return box.values.toList();
    });
  }
}