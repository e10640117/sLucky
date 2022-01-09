
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos/model/staff_model.dart';
import 'package:macos/widget/staff_info_dialog.dart';

class StaffItem extends StatefulWidget{

  StaffModel staffModel;
  void Function()? itemClick;
  int? position;

  StaffItem(this.staffModel,{this.itemClick,this.position,Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaffItemState();
  }

}

class StaffItemState extends State<StaffItem>{
  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: (){
          print('onTap called');
          showDialog(context: context, builder: (context){
            return StaffInfoDialog(staffModel: widget.staffModel,position:widget.position,isModify: true,);
          });
        },
        child: Column(
          children: [
            SizedBox(height: 9,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width:20),
                 Container(
                   decoration: const BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(10))
                   ),
                   child:ClipOval(
                     child: Image(
                         fit: BoxFit.fill,
                         width: 60,
                         height: 60,
                         image: FileImage(File(widget.staffModel.imagePath!))
                     ),
                   ),
                 ),
                const SizedBox(width: 50,),
                Text("${widget.staffModel.name}")
              ],
            ),
            SizedBox(height:9),
            Divider(height: 1,)
          ],
        ),
      );
  }

}