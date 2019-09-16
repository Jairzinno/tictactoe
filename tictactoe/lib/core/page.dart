import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

typedef FuturePageLoader<T> = Future<T> Function(BuildContext context);
typedef StreamPageLoader<T> = Stream<T> Function(BuildContext context);
typedef PageWidgetBuilder<T> = Widget Function(
    BuildContext context, Future<T> data, Stream<T> stream);

class Page<T> extends StatelessWidget {
  static double devicePixelRatio = ui.window.devicePixelRatio;
  static ui.Size size = ui.window.physicalSize;
  static double width = size.width;
  static double height = size.height;
  static double screenWidth = width / devicePixelRatio;
  static double screenHeight = height / devicePixelRatio;
  static ui.Size screenSize = new ui.Size(screenWidth, screenHeight);

  final PageWidgetBuilder<T> onMobileBuilder;
  final PageWidgetBuilder<T> onTabletBuilder;
  final PageWidgetBuilder<T> onWebBuilder;
  final FuturePageLoader<T> onFuture;
  final StreamPageLoader<T> onStream;

  const Page(
      {Key key,
      @required this.onMobileBuilder,
      @required this.onTabletBuilder,
      @required this.onWebBuilder,
      this.onStream,
      this.onFuture})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var future = onFuture != null ? onFuture(context) : null;
    var stream = onStream != null ? onStream(context) : null;
    switch (_pageSize()) {
      case _PageSize.phone:
        return onMobileBuilder != null
            ? onMobileBuilder(context, future, stream)
            : Container();
      case _PageSize.tablet:
        return onTabletBuilder != null
            ? onTabletBuilder(context, future, stream)
            : Container();
      case _PageSize.web:
        return onWebBuilder != null
            ? onWebBuilder(context, future, stream)
            : Container();
      default:
        return Container();
    }
  }

  _PageSize _pageSize() {
    _PageSize _pageSize = _PageSize.phone;
    if (devicePixelRatio < 2 && (width >= 1920)) {
      _pageSize = _PageSize.web;
    } else if ((devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) ||
        devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      _pageSize = _PageSize.tablet;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      _pageSize = _PageSize.tablet;
    } else {
      _pageSize = _PageSize.phone;
    }
    return _pageSize;
  }
}

enum _PageSize { phone, tablet, web }
