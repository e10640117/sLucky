import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:macos/model/staff_model.dart';
import 'package:macos/widget/staff_info_widget.dart';
import 'package:macos/page/staff_manage_page.dart';
import 'package:path_provider/path_provider.dart';

class StaffInfoDialog extends Dialog{

  StaffModel? staffModel;
  bool isModify;
  int? position;

  StaffInfoDialog({this.staffModel,this.position,this.isModify = false});

  @override
  Widget build(BuildContext context) {
      return Material(
         type: MaterialType.transparency,
         child: Center(
           child: StaffInfoWidget(this,staffModel: staffModel,position:position,isModify: isModify,),
         ),
      );
  }
}