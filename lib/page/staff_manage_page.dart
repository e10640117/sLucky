

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos/Constant.dart';
import 'package:macos/event/StaffUpdateEvent.dart';
import 'package:macos/model/staff_config_model.dart';
import 'package:macos/util/file_util.dart';
import 'package:macos/widget/staff_info_dialog.dart';
import 'package:macos/widget/staff_item.dart';
import 'package:macos/model/staff_model.dart';
import 'package:path_provider/path_provider.dart';
class StaffManagerPage extends StatefulWidget{
  const StaffManagerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaffManagePageState();
  }
}

class StaffManagePageState extends State<StaffManagerPage>{

  List<StaffModel>? staffList;
  @override
  void initState(){
    _initConfig();
    Constants.eventBus.on<StaffUpdateEvent>().listen((event){
      print("event bus");
        _initConfig();
    });
    super.initState();
  }

  void _initConfig()async{
    StaffConfigModel config = await FileUtil.getStaffConfig();
    if(mounted){
      setState(() {
        staffList = config.list!;
        print(staffList.hashCode);
        print(config.list.hashCode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('员工管理'),
      ),
      body: staffList == null ? Container():ListView.builder(itemBuilder: (context,position){
        return StaffItem(staffList![position],position: position,);
      },
      itemCount: staffList!.length,
      itemExtent: 80,),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return StaffInfoDialog();
          });
        },
        tooltip: '添加员工',
        child: const Icon(Icons.add),
      ),
    );
  }

  _itemClick(int position){
    showDialog(context: context, builder: (context){
      return StaffInfoDialog(staffModel: staffList![position],isModify: true,);
    });
  }

}


