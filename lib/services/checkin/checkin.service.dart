import 'package:flutter/cupertino.dart';
import 'package:tsembisa/configurations/environment.dart' as environment;
import 'package:tsembisa/declarations/service.dart';
import 'package:tsembisa/models/checkin.model.dart';
import 'package:tsembisa_plugin/models/user.model.dart';

class CheckinService extends Service<CheckinModel> {
  /*
  this service will also need a data store to be able to store information
  on the local device.
   */
  CheckinService() : super(
    name: 'checkin',
    adapter: CheckinModel.adapter
  );

  /*
  Here there are multiple functions that need to be implemented in order to manage
  the check ins that user will be providing
   */
  Future<CheckinModel> create({
    @required int description,
  }) async {
    UserModel user = await shared;

    return getquestion()
    .then((question) {
      /*
      * We are going to need to check if the checkin question exists before we
      * make it happen here...*/
      if(question['QUESTION'] == null) {
        /*
        * Instead of throwing an error we can simply default to making a
        * standard checkin and the allowing the user to do a wellness checkin
        * ...*/
        return wellness(description: description);
      }

      return request({
        'response': description.toString(),
        'timestamp': DateTime.now().toIso8601String(),
        'mobile': user.mobile,
        'qid': int.parse(question['QUESTION_ID']),
      }, method: 'post', route: '${environment.host}/checkin_response.php')
      .then((value) {
        CheckinModel model = CheckinModel.fromJson({
          'description': description.toString(),
          'subtime': DateTime.now().toIso8601String()
        });

        return storage.then((box) {
          return box.put(model.id, model)
          .then((result) {

            return model;
          });
        });
      });
    });
  }

  Future<Map<String, dynamic>> getquestion() async {
    UserModel user = await shared;

    return request({
      'mobile': user.mobile,
      'time': '${DateTime.now().hour.toString().padLeft(2, '0')}:00'
    }, method: 'post', route: '${environment.host}/checkin_questions.php')
      .then((value) {
        return value;
      });
  }

  Future<CheckinModel> wellness({
    @required int description,
  }) async {
    UserModel user = await shared;

    return request({
      'response': description.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'mobile': user.mobile
    }, method: 'post', route: '${environment.host}/wellness_checkin.php')
      .then((value) {
        CheckinModel model = CheckinModel.fromJson({
          'description': description.toString(),
          'subtime': DateTime.now().toIso8601String()
        });
        /*
        * Then here we store the model...*/
        return storage.then((box) {
          return box.put(model.id, model)
          .then((result) {

            return model;
          });
        });
      });
  }

  Future<List<CheckinModel>> readall() {
    return storage.then((box) {
      return box.values.toList();
    });
  }
}