import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/mappers/mappers.dart';

class StringToBoolMapper implements MapperAdapter {

  final MapperAdapter _mapper;
  final DartType _numType;

  StringToBoolMapper(this._mapper, this._numType);

  @override
  Expression get expression {

    final mapperExpression = _mapper.expression;

    return _nullableStringToBoolExpression(mapperExpression);

  }

  Expression _nullableStringToBoolExpression(Expression variable) {

    final nullValue = refer('null');
    return variable.equalTo(nullValue).conditional(nullValue, variable.nullSafeProperty('toLowerCase').call([]).equalTo(refer('\'true\'')));

  }

  @override
  DartType get returnType => _numType;

}
