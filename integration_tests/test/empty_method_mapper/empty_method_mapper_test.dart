
import 'package:test/test.dart';
import 'empty_method_mapper.dart';

void main() {
  group('EmptyMethodMapper', () {

    test('Should be instantiated', () {
      expect(EmptyMethodMapper.INSTANCE, isNotNull);
    });

    test('Should return null', () {
      final model = Model()..field = 'test';
      expect(EmptyMethodMapper.INSTANCE.modelToDto(model), isNotNull);
    });

  });
}
