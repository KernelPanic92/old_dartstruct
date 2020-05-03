import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/mappers/mappers.dart';

class NumToBoolMapper implements MapperAdapter {

  final MapperAdapter _mapper;
  final DartType _boolType;

  NumToBoolMapper(this._mapper, this._boolType);

  @override
  Expression get expression {

    final mapperExpression = _mapper.expression;

    return _nullableNumToBool(mapperExpression);

  }

  Expression _nullableNumToBool(Expression variable) {

    final nullValue = refer('null');
    return variable.equalTo(nullValue).conditional(nullValue, _numToBool(variable));

  }

  Expression _numToBool(Expression variable) {

    return variable.greaterOrEqualTo(refer('1'));

  }

  @override
  DartType get returnType => _boolType;

}
