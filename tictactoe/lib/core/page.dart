import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

typedef StreamPageLoader<T> = Stream<T> Function(BuildContext context);
typedef PageWidgetBuilder<T> = Widget Function(
    BuildContext context, Stream<T> stream);

class Page<T> extends StatelessWidget {
  static double _devicePixelRatio = ui.window.devicePixelRatio;
  static ui.Size _size = ui.window.physicalSize;
  static double _width = _size.width;
  static double _height = _size.height;

  final PageWidgetBuilder<T> onMobileBuilder;
  final PageWidgetBuilder<T> onTabletBuilder;
  final PageWidgetBuilder<T> onWebBuilder;
  final StreamPageLoader<T> onStream;

  const Page({
    Key key,
    @required this.onMobileBuilder,
    @required this.onTabletBuilder,
    @required this.onWebBuilder,
    this.onStream,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var stream = onStream != null ? onStream(context) : null;
    switch (_pageSize()) {
      case _PageSize.phone:
        return onMobileBuilder != null
            ? onMobileBuilder(context, stream)
            : Container();
      case _PageSize.tablet:
        return onTabletBuilder != null
            ? onTabletBuilder(context, stream)
            : Container();
      case _PageSize.web:
        return onWebBuilder != null
            ? onWebBuilder(context, stream)
            : Container();
      default:
        return Container();
    }
  }

  _PageSize _pageSize() {
    _PageSize _pageSize = _PageSize.phone;
    if (_devicePixelRatio < 2 && (_width >= 1920)) {
      _pageSize = _PageSize.web;
    } else if ((_devicePixelRatio < 2 && (_width >= 1000 || _height >= 1000)) ||
        _devicePixelRatio == 2 && (_width >= 1920 || _height >= 1920)) {
      _pageSize = _PageSize.tablet;
    } else if (_devicePixelRatio == 2 && (_width >= 1920 || _height >= 1920)) {
      _pageSize = _PageSize.tablet;
    } else {
      _pageSize = _PageSize.phone;
    }
    return _pageSize;
  }
}

enum _PageSize { phone, tablet, web }
