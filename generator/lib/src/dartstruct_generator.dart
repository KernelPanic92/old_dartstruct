import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dartstruct/dartstruct.dart';

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
      ..methods.addAll(_generateMethods(classElement.methods));

    final mapperImpl = classBuilder.build();

    final code = '${mapperImpl.accept(_emitter)}';

    return _formatter.format(code);

  }

  List<Method> _generateMethods(List<MethodElement> methods) {
    if (methods.any((method) => method.isAbstract)) {
      throw InvalidGenerationSourceError('Not implemented yet',
        todo: 'remove all methods'
      );
    }

    return <Method>[];
  }
}
