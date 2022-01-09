import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:macos/marquee_widget.dart';
import 'package:macos/widget/setting_dialog.dart';
import 'package:macos/model/staff_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../Constant.dart';
import '../event/StaffUpdateEvent.dart';
import '../model/staff_config_model.dart';
import '../util/file_util.dart';


class LuckyPage extends StatefulWidget {
  const LuckyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LuckyPageState();
  }
}

class LuckyPageState extends State<LuckyPage> {
  late List<StaffModel> staffList = <StaffModel>[];
  StaffModel? currentStaff;
  var random = Random();
  Timer? timer;
  bool pause = true;
  Color bgColor = Colors.redAccent;
  String luckyedList = "";
  bool isEmpty = true;

  @override
  void initState() {
    _initConfig();
    super.initState();
  }

  void _initConfig()async{
    StaffConfigModel config = await FileUtil.getStaffConfig();
    setState(() {
      staffList.clear();
      if(config.list!.isNotEmpty){
        isEmpty = false;
        staffList.addAll(config.list!);
        currentStaff = staffList[0];
      }else{
        isEmpty = true;
      }
    });
  }

  void lucky(){
    if(isEmpty){
      showToast("未添加员工，请点击右上角设置按钮添加员工吧");
      return;
    }
    if(pause){
      if(staffList.isEmpty){
          showToast("剩余员工为0，请点击右上角刷新按钮");
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
        bgColor = Colors.yellowAccent;
        luckyedList = "$luckyedList\n${currentStaff!.name}";
        staffList.remove(currentStaff);
      });
      timer!.cancel();
    }
    setState(() {
      pause = !pause;
    });
  }

  void _reset(){
    showToast("重置成功");
    luckyedList = "";
    bgColor = Colors.yellowAccent;
    pause = true;
    timer?.cancel();
    _initConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF2170C),
        title: const Center(child: Text("昆山隆翰包装材料有限公司2021尾牙宴",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 26),)),
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
      body:Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/bg_lucky4.jpeg")
            )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: MarqueeWidget(
              direction: Axis.horizontal,
              child: const Text("感谢公司全体员工一年来的辛苦与付出！感谢亲朋好友一年来的支持与帮助！",style: TextStyle(
                  color: Colors.white,fontSize: 30
              ),),
            ),),
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
                          child: isEmpty ? Image(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/default.jpg")):
                          Image(
                            fit: BoxFit.fill,
                            image: FileImage(File(currentStaff!.imagePath!)),
                            // image: FileImage(File(currentStaff.headImage!)),
                          ),
                        ),
                      ),
                      Positioned(bottom:0 ,child: Container(
                        height:50 ,
                        width: 400,
                        color: bgColor,
                        child: Center(
                          child: Text("${isEmpty ? '霸道总裁':currentStaff!.name}",style: const TextStyle(
                              color: Colors.black
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
              bottom: 30,
              child: FocusableControlBuilder(

                builder: (BuildContext context, FocusableControlState control) {
                  return  InkWell(
                    onTap: lucky,
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
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }



  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

}
