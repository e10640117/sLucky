import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macos/page/staff_manage_page.dart';
import 'package:macos/util/file_util.dart';
import 'package:oktoast/oktoast.dart';

import '../Constant.dart';

class SettingDialog extends Dialog{

  Color bgColor = Color(0xffF2170C);

  @override
  Widget build(BuildContext context) {
      return Material(
         type: MaterialType.transparency,
         child: Center(
           child: Container(
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
                 SizedBox(height: 20,),
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
                 const SizedBox(height: 40,),
                 InkWell(
                   onTap: (){
                     showToast("敬请期待");
                   },
                     child: Container(
                         width: 250,
                         height: 50,
                         decoration: BoxDecoration(
                             border: Border.all(color:  Color(0xffF2170C),)
                         ),
                         child: Center(child: Text("设置背景图片",style: TextStyle(color: bgColor))))),
                 const SizedBox(height: 40,),
                 InkWell(
                   onTap: ()async{
                     showToast("敬请期待");
                   },
                     child: Container(
                         width: 250,
                         height: 50,
                         decoration: BoxDecoration(
                             border: Border.all(color:  Color(0xffF2170C),)
                         ),
                         child: Center(child: Text("设置标题",style: TextStyle(color: bgColor))))),
                 Expanded(child: Container()),
                 Text('小贴士:设置完成需点击刷新按钮或者重启程序才能生效',style: TextStyle(color: bgColor)),
                 SizedBox(height: 20),
               ],
             ),
           ),
         ),
      );
  }



}