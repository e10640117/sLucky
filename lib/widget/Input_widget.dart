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

class InputWidget extends StatefulWidget{

  String? title;
  String? defaultText;
  InputWidget({this.title,this.defaultText,Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InputWidgetState();
  }

}

class InputWidgetState extends State<InputWidget>{

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
      setState(() {
        controller.text = widget.defaultText!;
      });
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        width: 500,
        height: 320,
        decoration: BoxDecoration(
          border: Border.all(color:Constants.themeColor,width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Text(widget.title??'设置',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            SizedBox(height: 5,),
            Divider(height: 1,indent: 10,endIndent: 10,),
            Expanded(
              child: Container(
                width: 500,
                padding: EdgeInsets.only(left: 50,right: 50),
                child: Center(
                  child: TextField(
                    style: TextStyle(decorationColor: Constants.themeColor),

                      controller: controller,decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.themeColor)
                    ),
                    hintText: '请入内容',
                    labelText: '内容',
                    prefixIcon: Icon(Icons.create),
                  )),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()async{
                    Navigator.of(context).pop(controller.text);
                  },
                  child: Container(
                    width: 180,
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
                        Text('确认',style: TextStyle(color: Constants.themeColor),),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30,),

                InkWell(
                  onTap: (){
                      Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 180,
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
                        Text("取消",style: TextStyle(color: Constants.themeColor),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      );
  }

}