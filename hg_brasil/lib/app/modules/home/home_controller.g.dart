// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$appAtom = Atom(name: '_HomeControllerBase.app');

  @override
  AppController get app {
    _$appAtom.reportRead();
    return super.app;
  }

  @override
  set app(AppController value) {
    _$appAtom.reportWrite(value, super.app, () {
      super.app = value;
    });
  }

  @override
  String toString() {
    return '''
app: ${app}
    ''';
  }
}
