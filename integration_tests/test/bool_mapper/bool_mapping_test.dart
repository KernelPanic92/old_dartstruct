
import 'package:test/test.dart';

import 'bool_mapper.dart';




void main() {
  group('Bool Mapper', () {

    final model = Model()
      ..trueString$ = 'true'
      ..falseString$ = 'string'
      ..nullString$ = null
      ..trueDouble$ = 1.1
      ..falseDouble$ = 0
      ..nullDouble$ = null
      ..trueInteger$ = 100
      ..falseInteger$ = 0
      ..trueNumber$ = 1
      ..falseNumber$ = 0
      ..nullNumber$ = null
      ..true$ = true
      ..false$ = false
      ..nullBool$ = null;


    test('Should be instantiated', () {
      expect(BoolMapper.INSTANCE, isNotNull);
    });

    test('Should assign field when input is number', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.trueNumber$, equals(true));
      expect(actual.falseNumber$, equals(false));

    });

     test('Should assign field when input is null number', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.nullNumber$, equals(null));

    });

    test('Should assign field when input is integer', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.trueInteger$, equals(true));
      expect(actual.falseInteger$, equals(false));

    });

     test('Should assign field when input is null integer', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.nullInteger$, equals(null));

    });

    test('Should assign field when input is double', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.trueDouble$, equals(true));
      expect(actual.falseDouble$, equals(false));

    });

     test('Should assign field when input is null double', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.nullDouble$, equals(null));

    });

    test('Should assign field when input is string', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.trueString$, equals(true));
      expect(actual.falseString$, equals(false));

    });

    test('Should assign field when input is null string', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.nullString$, equals(null));

    });

     test('Should assign field when input is bool', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.true$, equals(true));
      expect(actual.false$, equals(false));

    });

     test('Should assign field when input is null bool', () {

      final actual = BoolMapper.INSTANCE.modelToDto(model);
      expect(actual.nullBool$, equals(null));

    });

  });
}
