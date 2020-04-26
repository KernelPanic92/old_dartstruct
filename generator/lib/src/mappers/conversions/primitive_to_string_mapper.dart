import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/mappers/mappers.dart';

class PrimitiveToStringMapper implements MapperAdapter {

  final MapperAdapter _mapper;
  final DartType _stringType;

  PrimitiveToStringMapper(this._mapper, this._stringType);

  @override
  Expression get expression => _mapper.expression.nullSafeProperty('toString').call([]);

  @override
  DartType get returnType => _stringType;

}
