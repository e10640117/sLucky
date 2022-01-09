

import 'package:macos/model/staff_model.dart';

class StaffConfigModel{


  List<StaffModel>? list;

  StaffConfigModel({this.list});

  StaffConfigModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <StaffModel>[];
      json['list'].forEach((v) {
        list!.add( StaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}