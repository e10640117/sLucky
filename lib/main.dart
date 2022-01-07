import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:focusable_control_builder/focusable_control_builder.dart';
import 'package:macos/lucky_page.dart';
import 'package:macos/page_route.dart';
import 'package:macos/pop_up.dart';
import 'package:macos/staff_manage_page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  // runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const LuckyPage()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? filePath = '';

  _toManage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const StaffManagerPage();
    }));
  }
  void _toLucky(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return const LuckyPage();
    }));
  }


  Future<void> _incrementCounter() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {

      File file = File(result.files.single.path!);
      var directory = await getApplicationDocumentsDirectory();
      File newFile = await file.copy('${directory.path}/temp${DateTime.now().millisecond}');
      print(newFile.path);
      setState(() {
        filePath = newFile.path;

      });
      print(directory.path);
      print("filepath:$filePath");
    } else {

    }
  }

  void _showPop(double left,double top){
    Navigator.push(context, PopRoute(child: Popup(
      child:Container(
        width: 150,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Center(
          child: Text("selina你是我的老婆"),
        ),
      ),
      left: left,
      top: top,
      onClick: (){
        print("exit");
      },
    ),),);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FocusableControlBuilder(
        // onPressed: _incrementCounter,
        builder: (BuildContext context, FocusableControlState control) {
          return  Listener(
            onPointerUp: (event){
              print("鼠标抬起，button类型是${event.buttons}");
               if(event.buttons == 0){

               }else if(event.buttons == 1){

               }else if(event.buttons == 2){

               }
            },
            onPointerDown: (event){
              print("鼠标按下，button类型是${event.buttons}");
              if(event.buttons == 2){
                _showPop(event.position.dx,event.position.dy);
              }
            },
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  filePath!='' ? Image(
                      width: 200,
                      height: 200,
                      image:  FileImage(File(filePath!))
                  ):Container()
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: (){
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context){
        //     return const LuckyPage();
        //   }));
        // },
        // onPressed: _incrementCounter,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return const StaffManagerPage();
          }));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
