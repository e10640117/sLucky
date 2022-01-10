import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:macos/model/config_model.dart';
import 'package:macos/page/staff_manage_page.dart';
import 'package:macos/util/file_util.dart';
import 'package:macos/widget/setting_widget.dart';
import 'package:oktoast/oktoast.dart';

import '../Constant.dart';

class SettingDialog extends Dialog{



  @override
  Widget build(BuildContext context) {
      return const Material(
         type: MaterialType.transparency,
         child: Center(
           child: SettingWidget(),
         ),
      );
  }



}