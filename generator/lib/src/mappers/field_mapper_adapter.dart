import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/models/input_source.dart';

import 'mappers.dart';

class FieldMapperAdapter implements MapperAdapter {
  final FieldElement _fieldElement;
  final MapperAdapter _mapper;

  FieldMapperAdapter(this._mapper, this._fieldElement);

  @override
  Expression get expression => _mapper.expression.property(_fieldElement.displayName);

  @override
  DartType get returnType => _fieldElement.type;

  static FieldMapperAdapter create(InputSource input, String fieldName) {

    MapperAdapter mapper = InputSourceMapperAdapter(input);

    final classElement = input.type.element as ClassElement;

    final inputFieldElement = classElement.fields.firstWhere((field) => field.displayName == fieldName && field.getter != null, orElse: () => null);

    if (inputFieldElement == null) {
      return null;
    }

    return FieldMapperAdapter(mapper, inputFieldElement);
  }
}
