// Mocks generated by Mockito 5.4.3 from annotations
// in control_loop_test/test/sim/tube_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:control_loop_test/sim/ball.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [Ball].
///
/// See the documentation for Mockito's code generation for more information.
class MockBall extends _i1.Mock implements _i2.Ball {
  @override
  double get position => (super.noSuchMethod(
        Invocation.getter(#position),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  set position(double? _position) => super.noSuchMethod(
        Invocation.setter(
          #position,
          _position,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get velocity => (super.noSuchMethod(
        Invocation.getter(#velocity),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  set velocity(double? _velocity) => super.noSuchMethod(
        Invocation.setter(
          #velocity,
          _velocity,
        ),
        returnValueForMissingStub: null,
      );

  @override
  double get mass => (super.noSuchMethod(
        Invocation.getter(#mass),
        returnValue: 0.0,
        returnValueForMissingStub: 0.0,
      ) as double);

  @override
  set mass(double? _mass) => super.noSuchMethod(
        Invocation.setter(
          #mass,
          _mass,
        ),
        returnValueForMissingStub: null,
      );

  @override
  void update(
    double? force,
    double? timeStep,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #update,
          [
            force,
            timeStep,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void reset() => super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValueForMissingStub: null,
      );
}