import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:macos/Constant.dart';
import 'package:macos/model/config_model.dart';
import 'package:macos/model/staff_config_model.dart';
import 'package:macos/model/staff_model.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil{

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
      return ConfigModel('', '', '', '');
    }
    Map<String,dynamic> json = jsonDecode(buffer);
    return ConfigModel.fromJson(json);
  }

  static Future<File> setConfig(ConfigModel config) async{
    var diretory = await getApplicationDocumentsDirectory();
    File file =  File('${diretory.path}${Constants.settingPath}');
    String configStr = jsonEncode(config);
    return file.writeAsString(configStr);
  }

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




  static Future<File?> selectPhoto(String fileName) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      var directory = await getApplicationDocumentsDirectory();
      File newFile = await file.copy('${directory.path}/${DateTime.now().microsecondsSinceEpoch}');
      return newFile;
    } else {
      return null;
    }
  }

}