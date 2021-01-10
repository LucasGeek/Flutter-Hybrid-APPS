// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $PrincipalController = BindInject(
  (i) => PrincipalController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrincipalController on _PrincipalControllerBase, Store {
  final _$valueAtom = Atom(name: '_PrincipalControllerBase.value');

  @override
  String get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(String value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_PrincipalControllerBaseActionController =
      ActionController(name: '_PrincipalControllerBase');

  @override
  void setVal(String val) {
    final _$actionInfo = _$_PrincipalControllerBaseActionController.startAction(
        name: '_PrincipalControllerBase.setVal');
    try {
      return super.setVal(val);
    } finally {
      _$_PrincipalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
