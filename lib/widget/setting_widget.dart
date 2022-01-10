import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos/Constant.dart';
import 'package:macos/event/ConfigUpdateEvent.dart';
import 'package:macos/widget/input_dialog.dart';
import 'package:oktoast/oktoast.dart';

import '../model/config_model.dart';
import '../page/staff_manage_page.dart';
import '../util/file_util.dart';

class SettingWidget extends StatefulWidget{
  const SettingWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SettingWidgetState();
  }

}

class SettingWidgetState extends State<SettingWidget>{

  Color bgColor = Color(0xffF2170C);
  bool checked = true;
  String? title;
  String? leftContent;
  String? rightContent;


  @override
  void initState() {
    _logConfig();
    super.initState();
  }

  _logConfig()async{
    ConfigModel configModel = await FileUtil.getConfig();
    title = configModel.title!.isEmpty?Constants.defaultTitle:configModel.title!;
    leftContent = configModel.leftContent!.isEmpty?Constants.leftContent:configModel.leftContent!;
    rightContent = configModel.rightContent!.isEmpty?Constants.rightContent:configModel.rightContent!;
    setState(() {
      checked = configModel.useDefaultBg!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 400,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffF2170C),width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Text("设置",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: bgColor),),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return StaffManagerPage();
              })).then((value) => Navigator.of(context).pop());
            },
            child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color:  Color(0xffF2170C),)
              ),
              child: Center(
                child: Text("员工管理",style: TextStyle(color: bgColor),),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          InkWell(
              onTap: ()async{
                File? file = await FileUtil.selectPhoto();
                if(file !=null){
                  ConfigModel configModel = await FileUtil.getConfig();
                  configModel.bgPath = file.path;
                  configModel.useDefaultBg = false;
                  setState(() {
                    checked = false;
                  });
                  FileUtil.setConfig(configModel);
                  Constants.eventBus.fire(ConfigUpdateEvent(configModel));
                }
              },
              child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color:  Color(0xffF2170C),)
                  ),
                  child: Center(child: Text("更换背景图片",style: TextStyle(color: bgColor))))),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                child: Checkbox(value: checked, onChanged: (change) async {
                  ConfigModel configModel = await FileUtil.getConfig();
                  if(!change! && configModel.bgPath!.isEmpty){
                      showToast("请先选择背景图片再取消使用默认背景");
                      return ;
                  }
                  configModel.useDefaultBg = change;
                  FileUtil.setConfig(configModel);
                  setState(() {
                      checked = change;
                    });
                  Constants.eventBus.fire(ConfigUpdateEvent(configModel));
                }),
              ),
              SizedBox(width: 5,),
              Text('使用默认背景'),
              SizedBox(width: 25)
            ],
          ),
          SizedBox(height: 10,),
          InkWell(
              onTap: ()async{
                showDialog(context: context, builder: (context){
                  return InputDialog(title: '设置标题',defaultText: title,);
                }).then((value) async{
                  if(value !=null && value is String){
                    print('value：${value}');
                    ConfigModel configModel = await FileUtil.getConfig();
                    configModel.title = value;
                    FileUtil.setConfig(configModel);
                    Constants.eventBus.fire(ConfigUpdateEvent(configModel));
                    title = value;
                  }
                });
              },
              child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color:  Color(0xffF2170C),)
                  ),
                  child: Center(child: Text("设置标题",style: TextStyle(color: bgColor))))),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: ()async{
                    showDialog(context: context, builder: (context){
                      return InputDialog(title: '编辑左对联',defaultText: leftContent,);
                    }).then((value) async{
                      if(value !=null && value is String){
                        print('value：${value}');
                        ConfigModel configModel = await FileUtil.getConfig();
                        configModel.leftContent = value;
                        FileUtil.setConfig(configModel);
                        Constants.eventBus.fire(ConfigUpdateEvent(configModel));
                        leftContent = value;
                      }
                    });
                  },
                  child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color:  Color(0xffF2170C),)
                      ),
                      child: Center(child: Text("编辑左对联",style: TextStyle(color: bgColor))))),
              SizedBox(width: 10,),
              InkWell(
                  onTap: ()async{
                    showDialog(context: context, builder: (context){
                      return InputDialog(title: '编辑右对联',defaultText: rightContent,);
                    }).then((value) async{
                      if(value !=null && value is String){
                        print('value：${value}');
                        ConfigModel configModel = await FileUtil.getConfig();
                        configModel.rightContent = value;
                        FileUtil.setConfig(configModel);
                        Constants.eventBus.fire(ConfigUpdateEvent(configModel));
                        rightContent = value;
                      }
                    });
                  },
                  child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color:  Color(0xffF2170C),)
                      ),
                      child: Center(child: Text("编辑右对联",style: TextStyle(color: bgColor))))),
            ],


          ),
          Expanded(child: Container()),
          Text('小贴士:设置员工信息后需点击刷新按钮或者重启程序才能生效',style: TextStyle(color: bgColor)),
          SizedBox(height: 10),
        ],
      ),
    );
  }

}