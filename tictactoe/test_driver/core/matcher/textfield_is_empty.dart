import 'package:test/test.dart';

import 'textfield_contains_text.dart';

class TextFieldIsEmpty extends Matcher {
  const TextFieldIsEmpty();
  @override
  Description describe(Description description) {
    return description.add('textfield is empty');
  }

  @override
  bool matches(item, Map matchState) {
    final matcher = TextFieldContains('');
    return matcher.matches(item, matchState);
  }
}
