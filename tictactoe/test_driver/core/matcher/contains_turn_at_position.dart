import 'package:test/test.dart';

class ContainsTurnAtIndex extends Matcher {
  final int index;
  final String playerName;
  final String position;
  final String shape;
  final bool showStringProperties;

  ContainsTurnAtIndex(this.index, this.playerName, this.position, this.shape,
      {this.showStringProperties = false});

  @override
  Description describe(Description description) {
    return description
        .add('\'$playerName played $shape at $position in ListTile');
  }

  @override
  bool matches(item, Map<dynamic, dynamic> matchState) {
    List<Map<String, Object>> results = [];
    _matchProperties(0, item,
        results: results,
        propertyCriteria: 'DiagnosticableTreeNode',
        descriptionCriteria: '_RenderListTile');
    if (results.isEmpty) {
      return false;
    }
    try {
      List<Map<String, Object>> shapeResult = [];
      List<Map<String, Object>> positionResult = [];
      List<Map<String, Object>> nameResult = [];
      _matchProperties(0, results[index],
          results: shapeResult,
          propertyCriteria: 'DiagnosticsProperty<dynamic>',
          descriptionCriteria: shape);
      _matchProperties(0, results[index],
          results: positionResult,
          propertyCriteria: 'StringProperty',
          descriptionCriteria: position);
      _matchProperties(0, results[index],
          results: nameResult,
          propertyCriteria: 'StringProperty',
          descriptionCriteria: playerName);
      bool hasCorrectShape = shapeResult.isNotEmpty;
      bool hasCorrectPosition = positionResult.isNotEmpty;
      bool hasCorrectPlayerName = nameResult.isNotEmpty;
      return hasCorrectShape && hasCorrectPosition && hasCorrectPlayerName;
    } catch (e) {
      return false;
    }
  }

  void _matchProperties(int level, Map<String, Object> item,
      {List<Map<String, Object>> results,
      String propertyCriteria,
      String descriptionCriteria}) {
    _matchProperty(level, item, null,
        type: 'endNode',
        results: results,
        propertyCriteria: propertyCriteria,
        descriptionCriteria: descriptionCriteria);
    _matchProperty(level, item, 'properties',
        type: 'property',
        results: results,
        propertyCriteria: propertyCriteria,
        descriptionCriteria: descriptionCriteria);
    _matchProperty(level, item, 'children',
        type: 'child',
        results: results,
        propertyCriteria: propertyCriteria,
        descriptionCriteria: descriptionCriteria);
  }

  void _matchProperty(int level, Map<String, Object> item, String name,
      {String type,
      List<Map<String, Object>> results,
      String propertyCriteria,
      String descriptionCriteria}) {
    if (name == null) {
      _checkNode(item, level, type,
          results: results,
          propertyCriteria: propertyCriteria,
          descriptionCriteria: descriptionCriteria);
    } else {
      final currentItem = item[name];
      if (currentItem != null) {
        for (Map<String, Object> property in currentItem) {
          _checkNode(property, level, type,
              results: results,
              propertyCriteria: propertyCriteria,
              descriptionCriteria: descriptionCriteria);
        }
      }
    }
  }

  void _checkNode(Map<String, Object> property, int level, String type,
      {List<Map<String, Object>> results,
      String propertyCriteria,
      String descriptionCriteria}) {
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

    if (propertyType.contains(propertyCriteria) &&
        description.contains(descriptionCriteria) &&
        !results.contains(property)) {
      results.add(property);
    }

    if (showStringProperties) {
      String tabs = '';
      for (int i = 0; i < level; i++) {
        tabs += '  ';
      }
      print(
          '$level. $type $tabs Description: $description. Value: $value. Children: ${_children.length}. Properties: ${_properties.length}');
    }

    for (Object _child in _children) {
      _matchProperties(level + 1, _child,
          results: results,
          propertyCriteria: propertyCriteria,
          descriptionCriteria: descriptionCriteria);
    }
    for (Object _property in _properties) {
      _matchProperties(level + 1, _property,
          results: results,
          propertyCriteria: propertyCriteria,
          descriptionCriteria: descriptionCriteria);
    }
  }
}
