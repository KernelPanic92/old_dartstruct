
import 'package:test/test.dart';

import 'string_mapper.dart';


void main() {
  group('String Mapper', () {

    final model = Model()
      ..string$ = 'string'
      ..double$ = 1.1
      ..integer$ = 1
      ..number$ = 4
      ..bool$ = true;


    test('Should be instantiated', () {
      expect(StringMapper.INSTANCE, isNotNull);
    });

    test('Should assign field when input is number', () {

      final actual = StringMapper.INSTANCE.modelToDto(model);
      expect(actual.number$, equals('4'));

    });

    test('Should assign field when input is integer', () {

      final actual = StringMapper.INSTANCE.modelToDto(model);
      expect(actual.integer$, equals('1'));

    });
    test('Should assign field when input is double', () {

      final actual = StringMapper.INSTANCE.modelToDto(model);
      expect(actual.double$, equals('1.1'));

    });

    test('Should assign field when input is string', () {

      final actual = StringMapper.INSTANCE.modelToDto(model);
      expect(actual.string$, equals('string'));

    });

     test('Should assign field when input is bool', () {

      final actual = StringMapper.INSTANCE.modelToDto(model);
      expect(actual.bool$, equals('true'));

    });

  });
}
