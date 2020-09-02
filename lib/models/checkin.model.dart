import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';

class CheckinModel {
    String _id;
    DateTime checktime, subtime;
    String description;
    bool submitted;

    static TypeAdapter<CheckinModel> adapter = _CheckinAdapter();

    CheckinModel({this.checktime, this.description, this.submitted, this.subtime, String id}) {
        if(id == null)
            _id = _generateid();
    }

    factory CheckinModel.fromJson(Map<dynamic, dynamic> json) {
        return CheckinModel(
            id: json['_id'],
            checktime: json.containsKey('checktime') ? DateTime.parse(json['checktime']) : DateTime.now(),
            description: json['description'],
            submitted: json['submitted'],
            subtime: json.containsKey('checktime') ? DateTime.parse(json['subtime']) : DateTime.now(),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this._id;
        data['checktime'] = this.checktime.toIso8601String();
        data['description'] = this.description;
        data['submitted'] = this.submitted;
        data['subtime'] = this.subtime.toIso8601String();
        return data;
    }

    String _generateid() {
        var random = Random.secure();
        var values = List<int>.generate(32, (i) => random.nextInt(256));

        return base64Url.encode(values);
    }

    get id => _id;
}
class _CheckinAdapter extends TypeAdapter<CheckinModel> {
    @override
    final typeId = 0;

    @override
    CheckinModel read(BinaryReader reader) {
        return CheckinModel.fromJson(reader.read());
    }

    @override
    void write(BinaryWriter writer, CheckinModel obj) {
        writer.write(obj.toJson());
    }
}