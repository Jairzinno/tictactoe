import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'device_detection_service.dart';
import 'device_type.dart';

class DeviceDetector extends StatelessWidget {
  final Widget child;

  static double devicePixelRatio = ui.window.devicePixelRatio;
  static ui.Size size = ui.window.physicalSize;
  static double width = size.width;
  static double height = size.height;
  static double screenWidth = width / devicePixelRatio;
  static double screenHeight = height / devicePixelRatio;
  static ui.Size screenSize = new ui.Size(screenWidth, screenHeight);

  const DeviceDetector({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DeviceDetectionService.instance().deviceType = _deviceType();
    return child;
  }

  DeviceType _deviceType() {
    DeviceType _pageSize = DeviceType.phone;
    if (devicePixelRatio < 2 && (width >= 1920)) {
      _pageSize = DeviceType.web;
    } else if ((devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) ||
        devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      _pageSize = DeviceType.tablet;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      _pageSize = DeviceType.tablet;
    } else {
      _pageSize = DeviceType.phone;
    }
    return _pageSize;
  }
}
