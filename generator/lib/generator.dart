import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/dartstruct_generator.dart';

Builder dartstructBuilder(BuilderOptions options) {
  return SharedPartBuilder([DartStructGenerator()], 'dartstructBuilder');
}
