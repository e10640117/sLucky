
import 'dart:io';

import 'package:flutter/cupertino.dart';

class StaffItem extends StatefulWidget{

  String? name;
  String? imagePath;

  StaffItem({Key? key,String? name,String? imagePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaffItemState();
  }

}

class StaffItemState extends State<StaffItem>{
  @override
  Widget build(BuildContext context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Container(
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(10))
             ),
             child: Image(
                 fit: BoxFit.fill,
                 width: 100,
                 height: 100,
                 image: FileImage(File(widget.imagePath!))
             ),
           ),
          const SizedBox(width: 50,),
          Text("${widget.name}")
        ],
      );
  }

}