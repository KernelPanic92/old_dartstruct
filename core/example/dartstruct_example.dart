import 'package:dartstruct/dartstruct.dart';

class Model {
  String field;
}

class Dto {
  String field;
}

@Mapper()
abstract class PostMapper {
  Dto modelToDto(Model post);
}
