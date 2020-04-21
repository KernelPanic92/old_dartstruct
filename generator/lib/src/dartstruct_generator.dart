import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dartstruct/dartstruct.dart';
import './extensions/extensions.dart';

class DartStructGenerator extends GeneratorForAnnotation<Mapper> {
  final _emitter = DartEmitter();
  final _formatter = DartFormatter();

  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {

    if (element is! ClassElement) {
      throw InvalidGenerationSourceError('${element.displayName} cannot be annotated with @Mapper',
        element: element,
        todo: 'Remove @Mapper annotation'
      );
    }

    final classElement = element as ClassElement;

    if (!classElement.constructors.any((c) => c.isDefaultConstructor)) {
      throw InvalidGenerationSourceError('${element.displayName} must provide a default constructor',
        element: element,
        todo: 'Provide a default constructor'
      );
    }

    final classBuilder = ClassBuilder()
      ..name = '${classElement.displayName}Impl'
      ..abstract = false
      ..extend = refer(classElement.displayName)
      ..methods.addAll(classElement.methods.where((method) => method.isAbstract).map(_generateMethod));

    final mapperImpl = classBuilder.build();

    final code = '${mapperImpl.accept(_emitter)}';

    return _formatter.format(code);

  }

  Method _generateMethod(MethodElement method) {

    if (method.parameters.isEmpty) {
      throw InvalidGenerationSourceError('Method must provide an argument',
        todo: 'add source parameter',
        element: method
      );
    }

    if (method.parameters.length != 1) {
      throw InvalidGenerationSourceError('Method must provide only one argument',
        todo: 'provide only one argument',
        element: method
      );
    }

    final source = method.parameters.first;

    if (source.isNamed) {
      throw InvalidGenerationSourceError('Named parameters are not supported',
        todo: 'provide a positional argument',
        element: source
      );
    }

    final sourceType = source.type;
    final returnType = method.returnType;

    if (returnType.isPrimitive || sourceType.isPrimitive) {
      throw InvalidGenerationSourceError('Primitive types are not supported',
        element: method
      );
    }

    if (sourceType.isFuture || returnType.isFuture) {
      throw InvalidGenerationSourceError('Future types are not supported',
        element: method
      );
    }

    if (sourceType.isCollection || returnType.isCollection) {
      throw InvalidGenerationSourceError('Collection types are not supported',
        element: method
      );
    }

    if (sourceType.isDynamic || returnType.isDynamic) {
      throw InvalidGenerationSourceError('Dynamic type is not supported',
        element: method
      );
    }

    return Method((builder) {
      builder
        ..annotations.add(CodeExpression(Code('override')))
        ..name = method.displayName
        ..requiredParameters.add(_generateSourceParameter(source))
        ..returns = refer(returnType.element.displayName)
        ..body = _generateMethodBody(method);
    });
  }

  Parameter _generateSourceParameter(ParameterElement source) {
    return Parameter((builder) {
      builder
        ..name = source.name
        ..type = refer(source.type.element.displayName);
    });
  }

  Code _generateMethodBody(MethodElement methodElement) {
    return Code('return null;');
  }

}
