import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
class Constants{

  static var settingPath = '/setting.json';
  static var staffConfigPath = '/staffConfig.json';

  static var themeColor = const Color.fromARGB(255, 33, 150, 243);

  static EventBus eventBus = EventBus();
}