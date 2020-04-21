
import 'package:dartstruct/dartstruct.dart';

part 'empty_method_mapper.g.dart';

class Model {
  String field;
}

class Dto {
  String field;
}

@Mapper()
abstract class EmptyMethodMapper {

  static EmptyMethodMapper get INSTANCE => EmptyMethodMapperImpl();

  Dto modelToDto(Model model);

}
