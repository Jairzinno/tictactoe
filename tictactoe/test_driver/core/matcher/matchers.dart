import 'package:test/test.dart';

import 'contains_color.dart';
import 'contains_turn_at_position.dart';
import 'does_not_contain_color.dart';
import 'textfield_contains_text.dart';
import 'textfield_is_empty.dart';

const Matcher textFieldIsEmpty = TextFieldIsEmpty();
Matcher textFieldContains(String text, {bool showStringProperties = false}) =>
    TextFieldContains(text, showStringProperties: showStringProperties);
Matcher containsColor(String color, {bool showStringProperties = false}) =>
    ContainsColor(color, showStringProperties: showStringProperties);
Matcher doesNotContainColor(String color,
        {bool showStringProperties = false}) =>
    DoesNotContainColor(color, showStringProperties: showStringProperties);

Matcher containsTurnAtIndex(
        int index, String position, String playerName, String shape,
        {bool showStringProperties = false}) =>
    ContainsTurnAtIndex(index, playerName, position, shape,
        showStringProperties: showStringProperties);
