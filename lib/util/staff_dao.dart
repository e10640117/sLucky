import 'package:macos/model/staff_model.dart';
import 'package:macos/util/file_util.dart';

import '../model/staff_config_model.dart';

class StaffDao{

  StaffConfigModel? config;

  factory StaffDao() => _getInstance();

  // instance的getter方法，singletonManager.instance获取对象
  static StaffDao get instance => _getInstance();

  // 静态变量_instance，存储唯一对象
  static StaffDao? _instance;

  // 获取对象
  static StaffDao _getInstance() {
    if (_instance == null) {
      // 使用私有的构造方法来创建对象
      _instance = StaffDao._internal();
    }
    return _instance!;
  }

  StaffDao._internal() {
    loadConfig();
  }

  loadConfig() async{
    StaffConfigModel staffConfig = await FileUtil.getStaffConfig();
    config = staffConfig;
  }

  addStaff(StaffModel staffModel){
    config!.list!.add(staffModel);
    FileUtil.setStaffConfig(config!);
  }

  updateStaff(StaffModel staffModel,int position){
    config!.list![position] = staffModel;
    FileUtil.setStaffConfig(config!);
  }

  deleteStaff(StaffModel staffModel){
      StaffModel target = config!.list!.firstWhere((element) => element.name == staffModel.name);
      bool remove = config!.list!.remove(target);
      print('remove${remove}');
      FileUtil.setStaffConfig(config!);
  }

}