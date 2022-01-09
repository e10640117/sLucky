import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macos/page/staff_manage_page.dart';
import 'package:macos/util/file_util.dart';

import '../Constant.dart';

class SettingDialog extends Dialog{

  @override
  Widget build(BuildContext context) {
      return Material(
         type: MaterialType.transparency,
         child: Center(
           child: Container(
             width: 600,
             height: 400,
             decoration: BoxDecoration(
                 border: Border.all(color:Constants.themeColor,width: 5),
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(10))
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(height: 10,),
                 Text("设置",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                 SizedBox(height: 10,),
                 InkWell(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return StaffManagerPage();
                     })).then((value) => Navigator.of(context).pop());
                   },
                     child: Text("员工管理")),
                 const SizedBox(height: 20,),
                 Text("设置背景图片"),
                 const SizedBox(height: 20,),
                 InkWell(
                   onTap: ()async{
                      String title = "这是新的标题";
                      var config = await FileUtil.getConfig();
                      config.title = title;
                      FileUtil.setConfig(config);
                   },
                     child: Text("设置标题"))
               ],
             ),
           ),
         ),
      );
  }



}