import 'device_type.dart';

class DeviceDetectionService {
  static DeviceDetectionService _instance;
  DeviceType deviceType;

  DeviceDetectionService._();

  factory DeviceDetectionService.instance() {
    if (_instance == null) {
      _instance = DeviceDetectionService._();
    }
    return _instance;
  }
}
