import 'package:flutter/material.dart';
import 'package:macos/staff_manage_page.dart';

class SettingDialog extends Dialog{



  @override
  Widget build(BuildContext context) {
      return Material(
         type: MaterialType.transparency,
         child: Center(
           child: Container(
             width: 600,
             height: 400,
             decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.all(Radius.circular(10))
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(height: 10,),
                 Text("设置",style: TextStyle(fontStyle: FontStyle.italic),),
                 SizedBox(height: 10,),
                 InkWell(
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return StaffManagerPage();
                     })).then((value) => print('todo'));
                   },
                     child: Text("员工管理")),
                 const SizedBox(height: 20,),
                 Text("设置背景图片"),
                 const SizedBox(height: 20,),
                 Text("设置标题")
               ],
             ),
           ),
         ),
      );
  }

}