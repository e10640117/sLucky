import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:macos/Constant.dart';
import 'package:macos/event/StaffUpdateEvent.dart';
import 'package:macos/model/staff_model.dart';
import 'package:macos/util/file_util.dart';
import 'package:macos/util/staff_dao.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';

class StaffInfoWidget extends StatefulWidget{

  StaffModel? staffModel;
  bool isModify;
  Dialog dialog;
  int? position;
  StaffInfoWidget(this.dialog,{Key? key,this.staffModel,this.position,this.isModify = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaffInfoWidgetState();
  }

}

class StaffInfoWidgetState extends State<StaffInfoWidget>{

  TextEditingController controller = TextEditingController();

  StaffDao dao = StaffDao.instance;

  @override
  void initState() {
    if(widget.isModify){
      controller.text = widget.staffModel!.name!;
    }else{
      widget.staffModel = StaffModel('', '');
    }
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        width: 600,
        height: 420,
        decoration: BoxDecoration(
          border: Border.all(color:Constants.themeColor,width: 5),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Text("员工信息",style: TextStyle(fontWeight: FontWeight.w700),),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(width: 80,),
                Text('姓名',style: TextStyle(fontWeight: FontWeight.w600),),
                SizedBox(width: 80,),
                Container(
                  width: 200,
                  child: TextField(
                      controller: controller,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '请输入员工姓名',
                    labelText: '姓名',
                    prefixIcon: Icon(Icons.person),
                  )),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 80,),
                Text('照片',style: TextStyle(fontWeight: FontWeight.w600),),
                SizedBox(width: 80,),
                InkWell(
                  child:ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey
                      ),
                      child: (widget.staffModel == null || widget.staffModel!.imagePath!.isEmpty )?  Image(
                          fit: BoxFit.none,
                          width: 200,
                          height: 200,
                          image:
                          AssetImage("assets/images/icon_add.png")
                      ):Image(fit:BoxFit.fill,width:200,height:200,image:  FileImage(File(widget.staffModel!.imagePath!))),
                    )
                  ),
                  onTap: (){
                    _selectPhoto().then((value){
                      if(value!=null){
                        setState(() {
                          widget.staffModel!.imagePath = value.path;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()async{
                    if(controller.text.isEmpty){
                      showToast("请输入员工姓名");
                      return;
                    }
                    if(widget.staffModel!.imagePath!.isEmpty){
                      showToast("请选择员工照片");
                      return;
                    }
                    widget.staffModel!.name = controller.text;
                    if(widget.isModify){
                      await dao.updateStaff(widget.staffModel!,widget.position!);
                      Navigator.pop(context);
                      Constants.eventBus.fire(StaffUpdateEvent());
                    }else {
                      await dao.addStaff(widget.staffModel!);
                      Navigator.pop(context);
                      Constants.eventBus.fire(StaffUpdateEvent());
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Constants.themeColor,
                        width: 1,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.isModify ?'修改':'添加',style: TextStyle(color: Constants.themeColor),),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),

                Visibility(
                  visible: widget.isModify,
                  child: InkWell(
                    onTap: (){
                      dao.deleteStaff(widget.staffModel!);
                      Navigator.pop(context);
                      Constants.eventBus.fire(StaffUpdateEvent());
                    },
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Constants.themeColor,
                          width: 1,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("删除",style: TextStyle(color: Constants.themeColor),),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
  }

  Future<File?> _selectPhoto() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      var directory = await getApplicationDocumentsDirectory();
      File newFile = await file.copy('${directory.path}/${DateTime.now().microsecondsSinceEpoch}');
      print(newFile.path);
      return newFile;
    } else {
      return null;
    }
  }

}