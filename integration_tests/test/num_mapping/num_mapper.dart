

import 'package:dartstruct/dartstruct.dart';

part 'num_mapper.g.dart';

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
  num integer$;
  num nullInteger$;
  num string$;
  num nullString$;
  num number$;
  num nullNumber$;
  num double$;
  num nullDouble$;
  num true$;
  num false$;
  num nullBool$;
}


@Mapper()
abstract class NumMapper {

  static NumMapper get INSTANCE => NumMapperImpl();

  Dto modelToDto(Model model);

}
