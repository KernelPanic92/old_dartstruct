import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:recase/recase.dart';

class NameProvider {
  List<String> _names;

  NameProvider(ClassElement classElement) {
    _names = [
      classElement.displayName,
      ...classElement.accessors.map((accessor) => accessor.displayName).toSet(),
      ...classElement.methods.map((method) => method.displayName),
      ...classElement.constructors.map((constructor) => constructor.displayName).toSet()
    ];
  }

  NameProvider._privateConstructor(List<String> names) {
    _names = [ ...names ];
  }

  NameProvider forMethod(MethodElement methodElement) {
    return NameProvider._privateConstructor([
      ..._names,
      ...methodElement.parameters.map((parameter) => parameter.displayName)
    ]);
  }

  String provideVariableName(DartType type) {

    final displayName = type.element.displayName;

    final name = ReCase(displayName).camelCase;

    var nameWithIndex = name;
    var counter = 1;

    while(_names.contains(nameWithIndex)) {
      nameWithIndex = '$name$counter';
      counter++;
    }

    _names.add(nameWithIndex);

    return nameWithIndex;

  }
}
