

import 'package:dartstruct/dartstruct.dart';

part 'double_mapper.g.dart';

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
  double integer$;
  double nullInteger$;
  double string$;
  double nullString$;
  double number$;
  double nullNumber$;
  double double$;
  double nullDouble$;
  double true$;
  double false$;
  double nullBool$;
}


@Mapper()
abstract class DoubleMapper {

  static DoubleMapper get INSTANCE => DoubleMapperImpl();

  Dto modelToDto(Model model);

}
