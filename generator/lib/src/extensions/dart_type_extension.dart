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

    final element = this.element;

    if (element is ClassElement) {

      for (final constructor in element.constructors) {

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

  List<PropertyAccessorElement> get getters {

    final element = this.element;

    if (element is ClassElement) {
      return element.accessors.where((accessor) => accessor.isGetter).toList();
    }

    return <PropertyAccessorElement>[];

  }

  List<PropertyAccessorElement> get setters {

    final element = this.element;

    if (element is ClassElement) {
      return element.accessors.where((accessor) => accessor.isSetter).toList();
    }

    return <PropertyAccessorElement>[];

  }
}
