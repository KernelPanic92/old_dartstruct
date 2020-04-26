import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type_system.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:dartstruct_generator/src/name_provider.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dartstruct/dartstruct.dart';
import 'extensions/extensions.dart';
import 'mappers/conversions/conversions.dart';
import 'models/input_source.dart';
import 'models/output_source.dart';
import 'mappers/mappers.dart';
import 'dart:core';

class DartStructGenerator extends GeneratorForAnnotation<Mapper> {
  final _emitter = DartEmitter();
  final _formatter = DartFormatter();
  final _logger = Logger('dartstruct');
  Conversions _conversions;

  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {

    final dartCoreLibrary = await buildStep.resolver.findLibraryByName('dart.core');

    _conversions = Conversions(dartCoreLibrary);

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

    final nameProvider = NameProvider(classElement);


    final mapperImpl = Class((builder) {
      builder
        ..name = '${classElement.displayName}Impl'
        ..abstract = false
        ..extend = refer(classElement.displayName)
        ..methods.addAll(classElement.methods.where((method) => method.isAbstract).map((method) => _generateMethod(method, nameProvider.forMethod(method))));
    });

    final code = '${mapperImpl.accept(_emitter)}';

    return _formatter.format(code);

  }

  Method _generateMethod(MethodElement method, NameProvider nameProvider) {

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

    if (returnType.isDynamic) {
      throw InvalidGenerationSourceError('Dynamic type is not supported',
        element: method
      );
    }

    if (!returnType.hasEmptyConstructor) {
      throw InvalidGenerationSourceError('Return type must provide an empty parameters constructor',
        element: method.returnType.element
      );
    }

    return Method((builder) {
      builder
        ..annotations.add(CodeExpression(Code('override')))
        ..name = method.displayName
        ..requiredParameters.add(_generateSourceParameter(source))
        ..returns = refer(returnType.element.displayName)
        ..body = _generateMethodBody(method, nameProvider);
    });
  }

  Parameter _generateSourceParameter(ParameterElement source) {
    return Parameter((builder) {
      builder
        ..name = source.name
        ..type = refer(source.type.element.displayName);
    });
  }

  Code _generateMethodBody(MethodElement methodElement, NameProvider nameProvider) {

    final firstParameter = methodElement.parameters.first;

    final inputSource = InputSource(firstParameter.type, firstParameter.displayName);

    final outputSource = OutputSource(methodElement.returnType, nameProvider.provideVariableName(methodElement.returnType));

    final setters = (outputSource.type.element as ClassElement).fields.where((field) => field.setter != null);

    final blockBuilder = BlockBuilder()..addExpression(_instantiateOutputOrNull(inputSource, outputSource));

    for (final setter in setters) {

      final mapperExpression = _getMapperExpression(setter, inputSource);

      if (mapperExpression != null) {

        final assignmentExpression = refer(outputSource.name).nullSafeProperty(setter.displayName).assign(mapperExpression);
        blockBuilder.addExpression(assignmentExpression);

      } else {

        final unmappedFieldMessage = InvalidGenerationSourceError('unmapped field \'${setter.displayName}\'',
          element: setter
        );

        _logger.warning(unmappedFieldMessage.toString());

      }

    }

    blockBuilder.addExpression(refer(outputSource.name).returned);

    return blockBuilder.build();

  }

  Expression _getMapperExpression(FieldElement outputField, InputSource inputSource) {

    MapperAdapter mapper = FieldMapperAdapter.create(inputSource, outputField.displayName);

    if (mapper == null) {
      return null;
    }


    if (mapper.returnType != outputField.type && _conversions.canConvert(mapper.returnType, outputField.type)) {
      mapper = _conversions.convert(mapper.returnType, outputField.type, mapper);
      return mapper.expression;
    }

    return mapper.expression;

  }

  /// generate expression `final {output} = {input} == null ? null : new {output}()`
  Expression _instantiateOutputOrNull(InputSource input, OutputSource output) {

    final nullValue = refer('null');
    final inputValue = refer(input.name);
    final newInstanceExpression = refer(output.type.element.displayName).newInstance([]);

    return inputValue
          .equalTo(nullValue)
          .conditional(nullValue, newInstanceExpression).assignFinal(output.name);
  }

}
