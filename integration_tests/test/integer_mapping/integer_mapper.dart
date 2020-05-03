

import 'package:dartstruct/dartstruct.dart';

part 'integer_mapper.g.dart';

class Model {
  int integer$;
  int nullInteger$;
  String string$;
  String nullString$;
  num number$;
  num nullNumber$;
  double double$;
  double nullDouble$;
  bool true$;
  bool false$;
  bool nullBool$;
}

class Dto {
  int integer$;
  int nullInteger$;
  int string$;
  int nullString$;
  int number$;
  int nullNumber$;
  int double$;
  int nullDouble$;
  int true$;
  int false$;
  int nullBool$;
}


@Mapper()
abstract class IntegerMapper {

  static IntegerMapper get INSTANCE => IntegerMapperImpl();

  Dto modelToDto(Model model);

}
