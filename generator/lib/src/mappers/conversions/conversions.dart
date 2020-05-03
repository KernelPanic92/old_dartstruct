import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dartstruct_generator/src/mappers/conversions/bool_to_num_mapper.dart';
import 'package:dartstruct_generator/src/mappers/conversions/primitive_to_string_mapper.dart';
import 'package:dartstruct_generator/src/mappers/conversions/string_to_bool_mapper.dart';
import 'package:dartstruct_generator/src/mappers/conversions/string_to_num_mapper.dart';
import 'package:dartstruct_generator/src/mappers/mappers.dart';
import 'package:equatable/equatable.dart';
import 'num_to_bool_mapper.dart';
import 'num_to_num_mapper.dart';


class Conversions {

  final Map<_ConvertionKey, _MapperFactory> _convertions = HashMap<_ConvertionKey, _MapperFactory>();

  Conversions(LibraryElement dartCoreLibrary) {

    DartType intType = dartCoreLibrary.getType('int').thisType;
    DartType doubleType = dartCoreLibrary.getType('double').thisType;
    DartType boolType = dartCoreLibrary.getType('bool').thisType;
    DartType numType = dartCoreLibrary.getType('num').thisType;
    DartType stringType = dartCoreLibrary.getType('String').thisType;

    // to string
    _addConvertion(intType, stringType, (parent) => PrimitiveToStringMapper(parent, stringType));
    _addConvertion(doubleType, stringType, (parent) => PrimitiveToStringMapper(parent, stringType));
    _addConvertion(boolType, stringType, (parent) => PrimitiveToStringMapper(parent, stringType));
    _addConvertion(numType, stringType, (parent) => PrimitiveToStringMapper(parent, stringType));

    // to int
    _addConvertion(numType, intType, (parent) => NumToNumMapper(parent, intType));
    _addConvertion(doubleType, intType, (parent) => NumToNumMapper(parent, intType));
    _addConvertion(stringType, intType, (parent) => StringToNumMapper(parent, intType));
    _addConvertion(boolType, intType, (parent) => BoolToNumMapper(parent, intType));

    // to double
    _addConvertion(numType, doubleType, (parent) => NumToNumMapper(parent, doubleType));
    _addConvertion(intType, doubleType, (parent) => NumToNumMapper(parent, doubleType));
    _addConvertion(stringType, doubleType, (parent) => StringToNumMapper(parent, doubleType));
    _addConvertion(boolType, doubleType, (parent) => BoolToNumMapper(parent, doubleType));

    // to num
    _addConvertion(intType, numType, (parent) => NumToNumMapper(parent, numType));
    _addConvertion(doubleType, numType, (parent) => NumToNumMapper(parent, numType));
    _addConvertion(stringType, numType, (parent) => StringToNumMapper(parent, numType));
    _addConvertion(boolType, numType, (parent) => BoolToNumMapper(parent, numType));

     // to bool
    _addConvertion(intType, boolType, (parent) => NumToBoolMapper(parent, boolType));
    _addConvertion(doubleType, boolType, (parent) => NumToBoolMapper(parent, numType));
    _addConvertion(numType, boolType, (parent) => NumToBoolMapper(parent, numType));
    _addConvertion(stringType, boolType, (parent) => StringToBoolMapper(parent, numType));

  }

  bool canConvert(DartType from, DartType to) => _convertions.containsKey(_ConvertionKey(from, to));

  MapperAdapter convert(DartType from, DartType to, MapperAdapter parent) => _convertions[_ConvertionKey(from, to)](parent);

  void _addConvertion(DartType from, DartType to, _MapperFactory mapperFactory) {
    final key = _ConvertionKey(from, to);
    _convertions.putIfAbsent(key, () => mapperFactory);
  }

}

class _ConvertionKey extends Equatable {

  final DartType from;
  final DartType to;

  _ConvertionKey(this.from, this.to);

  @override
  List<Object> get props => [from, to];

}

typedef _MapperFactory = MapperAdapter Function(MapperAdapter parent);
