import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/mappers/mappers.dart';

class NumToNumMapper implements MapperAdapter {

  final MapperAdapter _mapper;
  final DartType _numType;

  NumToNumMapper(this._mapper, this._numType);

  @override
  Expression get expression {

    final mapperExpression = _mapper.expression;

    if (_numType.isDartCoreInt) {
      return mapperExpression.nullSafeProperty('toInt').call([]);
    }

    if (_numType.isDartCoreDouble) {
      return mapperExpression.nullSafeProperty('toDouble').call([]);
    }

    return mapperExpression;

  }

  @override
  DartType get returnType => _numType;

}
