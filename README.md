# dartstruct
An annotation processor inspired by mapstruct for generating type-safe mappers

## What is dartstruct?

dartstruct is a Dart annotation processor, inspired by Java MapStruct, for the generation of type-safe and performant mappers for dart classes. It saves you from writing mapping code by hand, which is a tedious and error-prone task.


dartstruct offers the following advantages:

- Fast execution by using plain method invocations
- Compile-time type safety. Only objects and attributes mapping to each other can be mapped, so there's no accidental mapping.
- Self-contained code: no runtime dependencies
- Clear error reports at build time if:
  - mappings are incomplete (not all target properties are mapped)
  - mappings are incorrect (cannot find a proper mapping method or type conversion)
  - Easily debuggable mapping code (or editable by hand—e.g. in case of a bug in the generator)

To create a mapping between two types, declare a mapper class like this:

```dart

@Mapper()
abstract class CarMapper {

    static CarMapper get INSTANCE => CarMapperImpl();

    CarDto carToCarDto(Car car);

}

```

The generated implementation uses plain Dart method invocations for mapping between source and target objects. Properties are mapped if they have the same name in source and target.

# Using dartstruct

Add the generator to your dev dependencies

```yaml

dependencies:
  dartstruct: any

dev_dependencies:
  dartstruct_generator: any
  build_runner: any

```

then run generator

```bash

pub run build_runner build  # Dart SDK
flutter pub run build_runner build # Flutter SDK

 ```
