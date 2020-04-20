
import 'package:test/test.dart';

import 'empty_mapper.dart';

void main() {
  group('EmptyMapper', () {

    test('Should not be null', () {
      expect(EmptyMapper.INSTANCE, isNotNull);
    });

  });
}
