// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$isExecuteAtom = Atom(name: '_HomeControllerBase.isExecute');

  @override
  bool get isExecute {
    _$isExecuteAtom.reportRead();
    return super.isExecute;
  }

  @override
  set isExecute(bool value) {
    _$isExecuteAtom.reportWrite(value, super.isExecute, () {
      super.isExecute = value;
    });
  }

  final _$startServiceAsyncAction =
      AsyncAction('_HomeControllerBase.startService');

  @override
  Future<void> startService() {
    return _$startServiceAsyncAction.run(() => super.startService());
  }

  final _$stopServiceAsyncAction =
      AsyncAction('_HomeControllerBase.stopService');

  @override
  Future<void> stopService() {
    return _$stopServiceAsyncAction.run(() => super.stopService());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void toggle() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.toggle');
    try {
      return super.toggle();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isExecute: ${isExecute}
    ''';
  }
}
