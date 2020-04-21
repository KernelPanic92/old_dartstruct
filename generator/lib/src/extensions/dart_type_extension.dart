import 'package:analyzer/dart/element/element.dart';
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

  bool get hasEmptyConstructor {

    if (element is ClassElement) {
      final classElement = element as ClassElement;

      for (final constructor in classElement.constructors) {

        final hasRequiredParameter = constructor.parameters.any(_isRequiredParameter);

        if (!hasRequiredParameter) {
          return true;
        }

      }
    }

    return false;

  }

  bool _isRequiredParameter(ParameterElement parameterElement) {
     return parameterElement.isRequiredNamed || parameterElement.isRequiredPositional || parameterElement.hasRequired;
  }
}
