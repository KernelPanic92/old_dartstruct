import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/mappers/mappers.dart';

class BoolToNumMapper implements MapperAdapter {

  final MapperAdapter _mapper;
  final DartType _numType;

  BoolToNumMapper(this._mapper, this._numType);

  @override
  Expression get expression {

    final mapperExpression = _mapper.expression;

    return _nullableBoolToNum(mapperExpression);

  }

  Expression _nullableBoolToNum(Expression variable) {

    final nullValue = refer('null');
    return variable.equalTo(nullValue).conditional(nullValue, _boolToNum(variable));

  }

  Expression _boolToNum(Expression variable) {

    final trueValue = refer('true');
    return variable.equalTo(trueValue).conditional(refer('1'), refer('0'));

  }

  @override
  DartType get returnType => _numType;

}
