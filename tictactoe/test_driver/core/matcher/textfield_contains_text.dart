import 'package:test/test.dart';

class TextFieldContains extends Matcher {
  final String text;
  final bool showStringProperties;

  TextFieldContains(this.text, {this.showStringProperties = false});

  @override
  Description describe(Description description) {
    return description
        .add('\'$text\' as value of a StringProperty in TextField');
  }

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    return _matchProperties(0, item);
  }

  bool _matchProperties(int level, Map<String, Object> item) {
    bool foundInItem = _matchProperty(level, item, null, type: 'endNode');
    bool foundInProperties =
        _matchProperty(level, item, 'properties', type: 'property');
    bool foundInChildren =
        _matchProperty(level, item, 'children', type: 'child');
    return foundInItem || foundInProperties || foundInChildren;
  }

  bool _matchProperty(int level, Map<String, Object> item, String name,
      {String type}) {
    bool foundMatch = false;
    if (name == null) {
      foundMatch = _checkNode(item, foundMatch, level, type);
    } else {
      final currentItem = item[name];
      if (currentItem != null) {
        for (Map<String, Object> property in currentItem) {
          foundMatch = _checkNode(property, foundMatch, level, type);
        }
      }
    }
    return foundMatch;
  }

  bool _checkNode(
      Map<String, Object> property, bool foundMatch, int level, String type) {
    String description = property['description'] != null
        ? property['description'].toString()
        : '';
    String value =
        property['value'] != null ? property['value'].toString() : '';
    String propertyType = property['type'];
    List<dynamic> _properties = [];
    List<dynamic> _children = [];
    if (property['properties'] != null) {
      _properties = property['properties'];
    }
    if (property['children'] != null) {
      _children = property['children'];
    }
    if (propertyType == 'StringProperty') {
      foundMatch = description.contains(text);
    }

    if (showStringProperties) {
      String tabs = '';
      for (int i = 0; i < level; i++) {
        tabs += '  ';
      }
      print(
          '$level. $type $tabs Description: $description. Value: $value. Children: ${_children.length}. Properties: ${_properties.length}');
    }
    if (foundMatch) {
      return true;
    }
    for (Object _child in _children) {
      foundMatch = _matchProperties(level + 1, _child);
      if (foundMatch) {
        return true;
      }
    }
    for (Object _property in _properties) {
      foundMatch = _matchProperties(level + 1, _property);
      if (foundMatch) {
        return true;
      }
    }
    return foundMatch;
  }
}
