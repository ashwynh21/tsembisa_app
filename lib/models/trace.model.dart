import 'dart:convert';
import 'dart:math';

import 'package:hive/hive.dart';

class TraceModel {
    String _id; // string
    DateTime date; // date
    String mobile; // string
    String fullname;

    static TypeAdapter<TraceModel> adapter = _TraceAdapter();

    TraceModel({String id, this.date, this.mobile, this.fullname}) {
        if(id == null)
            _id = _generateid();
    }

    factory TraceModel.fromJson(Map<String, dynamic> json) {
        return TraceModel(
            id: json['_id'],
            date: json.containsKey('date') ? DateTime.parse(json['date']) : DateTime.now(),
            mobile: json['mobile'],
            fullname: json['fullname'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['_id'] = this._id;
        data['date'] = this.date.toIso8601String();
        data['mobile'] = this.mobile;
        data['fullname'] = this.fullname;
        return data;
    }

    String _generateid() {
        var random = Random.secure();
        var values = List<int>.generate(32, (i) => random.nextInt(256));

        return base64Url.encode(values);
    }

    get id => _id;
}
class _TraceAdapter extends TypeAdapter<TraceModel> {
    @override
    final typeId = 1;

    @override
    TraceModel read(BinaryReader reader) {
        return TraceModel.fromJson(reader.readMap());
    }

    @override
    void write(BinaryWriter writer, TraceModel obj) {
        writer.write(obj.toJson());
    }
}