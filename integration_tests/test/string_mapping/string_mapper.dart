

import 'package:dartstruct/dartstruct.dart';

part 'string_mapper.g.dart';

class Model {
  int integer$;
  String string$;
  num number$;
  double double$;
  bool bool$;
}

class Dto {
  String integer$;
  String string$;
  String number$;
  String double$;
  String bool$;
}


@Mapper()
abstract class StringMapper {

  static StringMapper get INSTANCE => StringMapperImpl();

  Dto modelToDto(Model model);

}
