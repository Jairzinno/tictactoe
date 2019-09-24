import 'package:test/test.dart';

import 'contains_color.dart';

class DoesNotContainColor extends Matcher {
  final String color;
  final bool showStringProperties;

  DoesNotContainColor(this.color, {this.showStringProperties = false});

  @override
  Description describe(Description description) {
    return description.add(
        'not to have \'Color(${color.toLowerCase()})\' as value of a ColorProperty in Widget');
  }

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    final _containsColor = ContainsColor(color);
    return _containsColor.matches(item, matchState) == false;
  }
}
