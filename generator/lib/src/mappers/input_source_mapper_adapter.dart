import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:code_builder/src/specs/expression.dart';
import 'package:dartstruct_generator/src/models/input_source.dart';

import 'mapper_adapter.dart';

class InputSourceMapperAdapter implements MapperAdapter {

  final InputSource _source;

  InputSourceMapperAdapter(this._source);

  @override
  Expression get expression => refer(_source.name);

  @override
  DartType get returnType => _source.type;

}
