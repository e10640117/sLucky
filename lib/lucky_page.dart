import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:macos/marquee_widget.dart';
import 'package:macos/setting_dialog.dart';
import 'package:macos/staff_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';


class LuckyPage extends StatefulWidget {
  const LuckyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LuckyPageState();
  }
}

class LuckyPageState extends State<LuckyPage> {
  late List<StaffModel> staffList;
  late List<StaffModel> luckyedStaffList;
  late StaffModel currentStaff;
  var random = Random();
  late Timer timer;
  bool pause = true;
  String filePath1 = "assets/images/selina2.jpeg";
  String filePath2 =
      "assets/images/hebe2.jpeg";
  String filePath3 = "assets/images/ella2.jpeg";
  Color bgColor = Colors.redAccent;
  String luckyedList = "";

  @override
  void initState() {
    _loadConfig();
    staffList = [];
    luckyedStaffList = [];
    staffList.add(StaffModel("任家萱", filePath1));
    staffList.add(StaffModel("田馥甄", filePath2));
    staffList.add(StaffModel("陈嘉桦", filePath3));
    currentStaff = staffList[0];
    super.initState();
  }

  void _loadConfig()async{
    await rootBundle.loadString("assets/config.properties").then((config){
        print(config);
    });

    await rootBundle.loadString("assets/she.json").then((config){
        print(config);
    });

    var directory = await getApplicationDocumentsDirectory();
    print(directory.path);
  }

  void lucky(){
    if(pause){
      if(staffList.isEmpty){
          showToast("剩余员工为0，点击右上角重置按钮");
          return;
      }
      timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        int randomIndex = random.nextInt(staffList.length);
        setState(() {
          currentStaff = staffList[randomIndex];
          bgColor = Colors.redAccent;
        });
      });
    }else{
      setState(() {
        bgColor = Colors.yellow;
        luckyedList = "$luckyedList\n${currentStaff.name}";
        staffList.remove(currentStaff);
        luckyedStaffList.add(currentStaff);
      });
      timer.cancel();
    }
    setState(() {
      pause = !pause;
    });
  }

  void _reset(){
     staffList.clear();
     staffList.add(StaffModel("任家萱", filePath1));
     staffList.add(StaffModel("田馥甄", filePath2));
     staffList.add(StaffModel("陈嘉桦", filePath3));
     currentStaff = staffList[0];
     luckyedStaffList = [];
     luckyedList = "";
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Center(child: Text("昆山隆翰包装材料有限公司2021尾牙宴")),
        actions: [
          InkWell(
            onTap: _reset,
            child: const Icon(Icons.refresh),
          ),
            InkWell(onTap:(){
               showDialog(context: context, builder: (context){
                  return SettingDialog();
               });
            },child: const Icon(Icons.settings)),

        ],
      ),
      body: FocusableControlBuilder(
        onPressed: lucky,
        builder: (BuildContext context, FocusableControlState control) {
          return  Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/bg_lucky4.jpeg")
              )
            ),
            child: Column(
              children: [
                MarqueeWidget(
                  direction: Axis.horizontal,
                  child: const Text("感谢公司全体员工一年来的辛苦与付出！感谢亲朋好友一年来的支持与帮助！",style: TextStyle(
                      color: Colors.white,fontSize: 30
                  ),),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                        child: Container(
                          width: 100,
                          height: 400,
                          child: Column(
                      children: [
                          const Text("中奖名单",style: TextStyle(color: Colors.white),),
                          Text(luckyedList,style: TextStyle(color: Colors.white),)
                          // ListView(
                          //   children: luckyedStaffList.map((e) => Text("${e.name}")).toList()
                          // ),
                      ],
                    ),
                        )),
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
                                  color: bgColor,
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
                                    image: AssetImage(currentStaff.headImage!),
                                    // image: FileImage(File(currentStaff.headImage!)),
                                  ),
                                ),
                              ),
                              Positioned(bottom:0 ,child: Container(
                                height:50 ,
                                width: 400,
                                color: bgColor,
                                child: Center(
                                  child: Text("${currentStaff.name}",style: const TextStyle(
                                    color: Colors.white
                                  ),),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Positioned(
                      bottom: 20,
                      child: InkWell(
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(pause?"开始":"停止",style: const TextStyle(color: Colors.redAccent),),
                              const SizedBox(width: 10,),
                              Icon(pause? Icons.not_started_outlined:Icons.pause,color: Colors.redAccent,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
