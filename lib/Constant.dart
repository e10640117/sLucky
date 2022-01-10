import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
class Constants{

  static var settingPath = '/setting.json';
  static var staffConfigPath = '/staffConfig.json';
  static var defaultTitle = '昆山隆翰包装材料有限公司${DateTime.now().year-1}尾牙宴';
  static var leftContent = '感谢全体员工一年来的辛苦与付出';
  static var rightContent = '感谢亲朋好友一年来的支持与帮助';

  static var themeColor = const Color.fromARGB(255, 33, 150, 243);

  static EventBus eventBus = EventBus();
}