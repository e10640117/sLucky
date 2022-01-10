import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:macos/Constant.dart';
import 'package:macos/model/config_model.dart';
import 'package:macos/model/staff_config_model.dart';
import 'package:macos/model/staff_model.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil{
  /**
   * 从相册选择照片
   */
  static Future<File?> selectPhoto() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      var directory = await getApplicationDocumentsDirectory();
      File newFile = await file.copy('${directory.path}/${DateTime.now().microsecondsSinceEpoch}');
      print(newFile.path);
      return newFile;
    } else {
      return null;
    }
  }

  /**
   * 获取配置文件
   */
  static Future<ConfigModel> getConfig() async{
    var diretory = await getApplicationDocumentsDirectory();
    File file =  File('${diretory.path}${Constants.settingPath}');
    bool exist = await file.exists();
    if(!exist){
      await file.create();
    }
    print(file.path);
    String buffer = await file.readAsString();
    if(buffer.isEmpty){
      return ConfigModel('', '', '', '',true,'','');
    }
    Map<String,dynamic> json = jsonDecode(buffer);
    print(json);
    return ConfigModel.fromJson(json);
  }

  /**
   * 设置文件
   */
  static Future<File> setConfig(ConfigModel config) async{
    var diretory = await getApplicationDocumentsDirectory();
    File file =  File('${diretory.path}${Constants.settingPath}');
    String configStr = jsonEncode(config);
    return file.writeAsString(configStr);
  }

  /**
   * 获取员工列表
   */
  static Future<StaffConfigModel> getStaffConfig() async{
    var diretory = await getApplicationDocumentsDirectory();
    File file =  File('${diretory.path}${Constants.staffConfigPath}');
    bool exist = await file.exists();
    if(!exist){
      await file.create();
    }
    print(file.path);
    String buffer = await file.readAsString();
    if(buffer.isEmpty){
      return StaffConfigModel(list:<StaffModel>[]);
    }
    Map<String,dynamic> json = jsonDecode(buffer);
    return StaffConfigModel.fromJson(json);
  }

  /**
   * 设置员工列表文件
   */
  static Future<File> setStaffConfig(StaffConfigModel config) async{
    var diretory = await getApplicationDocumentsDirectory();
    File file =  File('${diretory.path}${Constants.staffConfigPath}');
    bool exist = await file.exists();
    if(!exist){
      await file.create();
    }
    print(file.path);
    String configStr = jsonEncode(config);
    return file.writeAsString(configStr);
  }

}