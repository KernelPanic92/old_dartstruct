
import 'package:test/test.dart';

import 'empty_mapper.dart';

void main() {
  group('EmptyMapper', () {

    test('Should be instantiated', () {
      expect(EmptyMapper.INSTANCE, isNotNull);
    });

  });
}
