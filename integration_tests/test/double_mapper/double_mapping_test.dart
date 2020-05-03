
import 'package:test/test.dart';

import 'double_mapper.dart';

void main() {
  group('Double Mapper', () {

    final model = Model()
      ..string$ = '7.1'
      ..nullString$ = null
      ..double$ = 1.1
      ..nullDouble$ = null
      ..integer$ = 1
      ..nullInteger$ = null
      ..number$ = 4
      ..nullNumber$ = null
      ..true$ = true
      ..false$ = false
      ..nullBool$ = null;


    test('Should be instantiated', () {
      expect(DoubleMapper.INSTANCE, isNotNull);
    });

    test('Should assign field when input is number', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.number$, equals(4.0));

    });

     test('Should assign field when input is null number', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.nullNumber$, equals(null));

    });

    test('Should assign field when input is integer', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.integer$, equals(1.0));

    });

     test('Should assign field when input is null integer', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.nullInteger$, equals(null));

    });

    test('Should assign field when input is double', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.double$, equals(1.1));

    });

     test('Should assign field when input is null double', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.nullDouble$, equals(null));

    });

    test('Should assign field when input is string', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.string$, equals(7.1));

    });

    test('Should assign field when input is null string', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.nullString$, equals(null));

    });

     test('Should assign field when input is bool', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.true$, equals(1.0));
      expect(actual.false$, equals(0));

    });

     test('Should assign field when input is null bool', () {

      final actual = DoubleMapper.INSTANCE.modelToDto(model);
      expect(actual.nullBool$, equals(null));

    });

  });
}
