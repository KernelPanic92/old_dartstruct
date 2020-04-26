import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/mappers/mappers.dart';

class StringToNumMapper implements MapperAdapter {

  final MapperAdapter _mapper;
  final DartType _numType;

  StringToNumMapper(this._mapper, this._numType);

  @override
  Expression get expression {

    final mapperExpression = _mapper.expression;

    if (_numType.isDartCoreInt) {
      return _parseExpression(mapperExpression, 'int');
    }

    if (_numType.isDartCoreDouble) {
      return _parseExpression(mapperExpression, 'double');
    }

    if (_numType.isDartCoreNum) {
      return _parseExpression(mapperExpression, 'num');
    }

    return _mapper.expression;

  }

  Expression _parseExpression(Expression variable, String parseTo) {
    final nullValue = refer('null');
    return variable.equalTo(nullValue).conditional(nullValue, refer(parseTo).property('parse').call([variable]));
  }

  @override
  DartType get returnType => _numType;

}
