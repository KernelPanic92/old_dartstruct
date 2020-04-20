
import 'package:dartstruct/dartstruct.dart';

part 'empty_mapper.g.dart';

@Mapper()
abstract class EmptyMapper {
  static EmptyMapper get INSTANCE => EmptyMapperImpl();
}
