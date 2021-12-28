import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:macos/staff_model.dart';


class LuckyPage extends StatefulWidget {
  const LuckyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LuckyPageState();
  }
}

class LuckyPageState extends State<LuckyPage> {
  late List<StaffModel> staffList;
  late StaffModel currentStaff;
  var random = Random();
  late Timer timer;
  bool pause = true;

  @override
  void initState() {
    staffList = [];
  String filePath1 = "assets/images/selina2.jpeg";
    String filePath2 =
        "/Users/mac/Documents/development/photo/hebe2.jpeg";
    String filePath3 = "/Users/mac/Documents/development/photo/ella2.jpeg";
    staffList.add(StaffModel("任家萱", filePath1));
    staffList.add(StaffModel("田馥甄", filePath2));
    staffList.add(StaffModel("陈嘉桦", filePath3));
    currentStaff = staffList[0];
    super.initState();
  }

  void lucky(){
    if(pause){
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        int randomIndex = random.nextInt(staffList.length);
        setState(() {
          currentStaff = staffList[randomIndex];
        });
      });
    }else{
      timer.cancel();
    }
    setState(() {
      pause = !pause;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("selina你是我的老婆"),
      ),
      body: FocusableControlBuilder(
        onPressed: lucky,
        builder: (BuildContext context, FocusableControlState control) {
          return  Column(
            children: [
              Center(
                child: ClipOval(
                  child: Container(
                    width: 400,
                    height: 400,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(child: ClipOval(
                          child: Container(
                            color: Colors.redAccent,
                          ),
                        )),
                        Positioned(
                          left: 10,
                          right: 10,
                          top: 10,
                          bottom: 10,
                          child:ClipOval(
                            child: Image(
                              fit: BoxFit.fill,
                              image: FileImage(File(currentStaff.headImage!)),
                            ),
                          ),
                        ),
                        Positioned(bottom:50 ,child: Text("${currentStaff.name}"))
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(pause?"开始":"停止",style: const TextStyle(color: Colors.redAccent),),
                      Icon(pause? Icons.not_started_outlined:Icons.pause,color: Colors.redAccent,)
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }



  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

}
