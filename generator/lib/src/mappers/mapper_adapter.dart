import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';

abstract class MapperAdapter {
  Expression get expression;
  DartType get returnType;
}
