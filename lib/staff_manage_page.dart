

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos/staff_item.dart';
import 'package:macos/staff_model.dart';
import 'package:path_provider/path_provider.dart';
class StaffManagerPage extends StatefulWidget{
  const StaffManagerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaffManagePageState();
  }
}

class StaffManagePageState extends State<StaffManagerPage>{

  late List<StaffModel> staffList;
  @override
  void initState() {
    staffList = [];
    String filePath = "/Users/mac/Library/Containers/com.example.macos/Data/Documents/temp83";
    staffList.add(StaffModel("任家萱",filePath));
    staffList.add(StaffModel("田馥甄",filePath));
    staffList.add(StaffModel("陈嘉桦",filePath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('员工管理'),
      ),
      body: ListView.builder(itemBuilder: (context,position){
        return StaffItem(staffList[position].name,staffList[position].headImage);
      },
      itemCount: staffList.length,
      itemExtent: 50,),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectPhoto,
        tooltip: '添加员工',
        child: const Icon(Icons.add),
      ),
    );
  }


  Future<void> _addStaff() async {

  }

  Future<File?> _selectPhoto() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      var directory = await getApplicationDocumentsDirectory();
      File newFile = await file.copy('${directory.path}/temp${DateTime.now().millisecond}');
      return newFile;
    } else {
      return null;
    }
  }
}


