import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
// import 'package:kplayer/kplayer.dart';
// import 'package:kplayer/kplayer.dart';
import 'package:macos/event/ConfigUpdateEvent.dart';
import 'package:macos/marquee_widget.dart';
import 'package:macos/model/config_model.dart';
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
  List<StaffModel> staffList = <StaffModel>[];
  StaffModel? currentStaff;
  var random = Random();
  Timer? timer;
  bool pause = true;
  Color bgColor = Colors.redAccent;
  String luckyedList = "";
  bool isEmpty = true;
  ConfigModel? config;
  bool useDefaultBg = true;
  int currentIndex = 0;
  int total = 0;

  @override
  void initState() {
    _initStaff();
    initConfig();
    _initPlayer();
    Constants.eventBus.on<ConfigUpdateEvent>().listen((event) {
      setState(() {
        this.config = event.configModel;
      });
    });
    super.initState();
  }

  void _initPlayer(){
    // PlayerController player = Player.asset("assets/RingRingRing.mp3");
    // player.play();
  }

  void _initStaff()async{
    StaffConfigModel staffConfig = await FileUtil.getStaffConfig();
    setState(() {
      staffList.clear();
      if(staffConfig.list!.isNotEmpty){
        isEmpty = false;
        staffList.addAll(staffConfig.list!);
        total = staffList.length;
        currentStaff = staffList[0];
      }else{
        isEmpty = true;
      }
    });
  }

  void initConfig()async{
    ConfigModel config = await FileUtil.getConfig();
    setState(() {
      this.config = config;
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
        int randomIndex = 0;
        if(staffList.length > 1){
          randomIndex = _randomIndex(staffList.length);
        }
        setState(() {
          currentStaff = staffList[randomIndex];
          bgColor = Colors.redAccent;
        });
      });
    }else{
      setState(() {
        bgColor = Colors.yellowAccent;
        luckyedList = "$luckyedList${currentStaff!.name}\n";
        staffList.remove(currentStaff);
      });
      timer!.cancel();
    }
    setState(() {
      pause = !pause;
    });
  }

  /**
   * 产生跟上次不一样的随机数，避免列表较少时随机到重复index导致界面看起来不够丝滑
   */
  int _randomIndex(int len){//
    int temp =  random.nextInt(len);
    while(currentIndex == temp){
      temp = random.nextInt(len);
    }
    currentIndex = temp;
    return temp;
  }

  void _reset(){
    showToast("刷新成功");
    luckyedList = "";
    bgColor = Colors.yellowAccent;
    pause = true;
    timer?.cancel();
    _initStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF2170C),
        title:  Text(config!= null && config!.title!.isNotEmpty ?  config!.title!:Constants.defaultTitle,style: TextStyle(fontWeight: FontWeight.w700,fontSize:40,color: Colors.yellow),),
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
      body:FocusableControlBuilder(
        requestFocusOnPress: true,
        onPressed: lucky,
        builder: (BuildContext context, FocusableControlState control) {
        return Container(
          decoration: BoxDecoration(
              image: (config != null && !config!.useDefaultBg! && config!.bgPath!=null && config!.bgPath!.isNotEmpty)? DecorationImage(fit:BoxFit.fill,image: FileImage(File(config!.bgPath!))):DecorationImage(
                  fit: BoxFit.fill,
                  image:  AssetImage("assets/images/bg_lucky4.jpeg")
              )
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  left: 100,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                    width: 100,
                    decoration: const BoxDecoration(image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/duilian_bg.jpeg'),
                    )),
                    child: Center(child: Text(formatContent(config!= null && config!.leftContent!.isNotEmpty ? config!.leftContent!:Constants.leftContent),style: const TextStyle(
                        color: Colors.yellow,fontSize: 26
                    ),)),
                  )),

              Positioned(
                  right: 100,
                  child: Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    width: 100,
                    decoration: BoxDecoration(image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/duilian_bg.jpeg'),
                    )),
                    child: Center(child: Text(formatContent(config!= null && config!.rightContent!.isNotEmpty ? config!.rightContent!:Constants.rightContent),style: TextStyle(
                        color: Colors.yellow,fontSize: 26
                    ),)),
                  )),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("总计$total人",style: TextStyle(color: Colors.white),),
                        Text("已中奖${total-staffList.length}人",style: TextStyle(color: Colors.white),),
                        Text("剩余${staffList.length}人",style: TextStyle(color: Colors.white),),
                        SizedBox(height: 5,),
                        const Text("中奖名单",style: TextStyle(color: Colors.white),),
                        Text(luckyedList,style: TextStyle(color: Colors.white),textAlign:TextAlign.center,)
                        // ListView(
                        //   children: luckyedStaffList.map((e) => Text("${e.name}")).toList()
                        // ),
                      ],
                    ),
                  )),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: bgColor,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  width: 400,
                  height: 400,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child:isEmpty ? Image(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/default.jpg")):
                        Image(
                          fit: BoxFit.fill,
                          image: FileImage(File(currentStaff!.imagePath!)),
                          // image: FileImage(File(currentStaff.headImage!)),
                        ),
                      ),
                      Positioned(bottom:0 ,child: Container(
                        height:40 ,
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
              const SizedBox(height: 20,),
              Positioned(
                  bottom: 30,
                  child: InkWell(
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
                  )
              ),
            ],
          ),
        );
      },

      )
    );
  }

  String formatContent(String content){
    StringBuffer sb = StringBuffer();
    content.characters.forEach((element) {
      sb.write('$element\n');
    });
    String result = sb.toString();
    return result.substring(0,result.length-1);

  }



  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

}
