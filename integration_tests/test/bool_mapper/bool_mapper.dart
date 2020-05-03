

import 'package:dartstruct/dartstruct.dart';

part 'bool_mapper.g.dart';

class Model {
  int trueInteger$;
  int falseInteger$;
  int nullInteger$;
  String trueString$;
  String falseString$;
  String nullString$;
  num trueNumber$;
  num falseNumber$;
  num nullNumber$;
  double trueDouble$;
  double falseDouble$;
  double nullDouble$;
  bool true$;
  bool false$;
  bool nullBool$;
}

class Dto {
  bool trueInteger$;
  bool falseInteger$;
  bool nullInteger$;
  bool trueString$;
  bool falseString$;
  bool nullString$;
  bool trueNumber$;
  bool falseNumber$;
  bool nullNumber$;
  bool trueDouble$;
  bool falseDouble$;
  bool nullDouble$;
  bool true$;
  bool false$;
  bool nullBool$;
}


@Mapper()
abstract class BoolMapper {

  static BoolMapper get INSTANCE => BoolMapperImpl();

  Dto modelToDto(Model model);

}
