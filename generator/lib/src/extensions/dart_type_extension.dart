import 'package:analyzer/dart/element/type.dart';

extension DartTypeExtension on DartType {

  bool get isPrimitive {
    return isDartCoreBool ||
      isDartCoreDouble ||
      isDartCoreFunction ||
      isDartCoreInt ||
      isDartCoreNum ||
      isDartCoreString ||
      isDartCoreSymbol;
  }

  bool get isFuture => isDartAsyncFuture || isDartAsyncFutureOr;

  bool get isCollection => isDartCoreMap || isDartCoreList || isDartCoreSet;

}
