
import 'package:dartstruct/dartstruct.dart';

part 'simple_mapper.g.dart';

class Model {
  String field;
}

class DifferentModel {
  String differentField;
}

class DifferentFieldTypeModel {
  int field;
}

class Dto {
  String field;
}

@Mapper()
abstract class SimpleMapper {

  static SimpleMapper get INSTANCE => SimpleMapperImpl();

  Dto modelToDto(Model model);

  Dto differentModelToDto(DifferentModel model);

  Dto differentFieldTypeModelToDto(DifferentFieldTypeModel model);

}
