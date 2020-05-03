
import 'package:test/test.dart';

import 'simple_mapper.dart';

void main() {
  group('Field Mapper', () {

    test('Should be instantiated', () {
      expect(SimpleMapper.INSTANCE, isNotNull);
    });

    test('Should return null when input is null', () {
      expect(SimpleMapper.INSTANCE.modelToDto(null), isNull);
    });

    test('Should not return null when input is not null', () {
      final model = Model()..field = 'test';
      expect(SimpleMapper.INSTANCE.modelToDto(model), isNotNull);
    });

    test('Should assign field when input has same field name and type', () {
      final model = Model()..field = 'test';
      final mappedResult = SimpleMapper.INSTANCE.modelToDto(model);
      expect(mappedResult.field, equals('test'));
    });

    test('Should not assign field when input has not same field name', () {
      final model = DifferentModel()..differentField = 'test';
      final mappedResult = SimpleMapper.INSTANCE.differentModelToDto(model);
      expect(mappedResult.field, isNull);
    });

    test('Should not assign field when input has different type', () {
      final model = DifferentFieldTypeModel()..field = DifferentModel();
      final mappedResult = SimpleMapper.INSTANCE.differentFieldTypeModelToDto(model);
      expect(mappedResult.field, isNull);
    });

  });
}
