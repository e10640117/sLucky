import 'package:flutter/cupertino.dart';
import 'package:macos/staff_item.dart';
import 'package:macos/staff_model.dart';
class StaffManagerPage extends StatefulWidget{
  const StaffManagerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StaffManagePageState();
  }
}

class StaffManagePageState extends State<StaffManagerPage>{

  late List<StaffModel> staffList;
  @override
  void initState() {
    staffList = [];
    String filePath = "/Volumes/mac os/Users/mac/Pictures/Photos Library.photoslibrary/originals/7/768DC2AF-E989-4317-9EBD-11CF169912C2.jpeg";
    staffList.add(StaffModel("任家萱",filePath));
    staffList.add(StaffModel("田馥甄",filePath));
    staffList.add(StaffModel("陈嘉桦",filePath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      // return ListView.builder(itemBuilder: (context,position){
      //     return StaffItem(name: staffList[position],imagePath: staffList[position].name,);
      // },itemCount: staffList.length,);
    return Column(
      children: [
        ListView.builder(itemBuilder: (context,position){
          return StaffItem(name: staffList[position].name,imagePath: staffList[position].headImage,);
        },
        itemCount: staffList.length,
        itemExtent: 50,)
      ],
    );
  }
  
}


