// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  final _$isMaterialAtom = Atom(name: '_AppControllerBase.isMaterial');

  @override
  bool get isMaterial {
    _$isMaterialAtom.reportRead();
    return super.isMaterial;
  }

  @override
  set isMaterial(bool value) {
    _$isMaterialAtom.reportWrite(value, super.isMaterial, () {
      super.isMaterial = value;
    });
  }

  final _$isCupertinoAtom = Atom(name: '_AppControllerBase.isCupertino');

  @override
  bool get isCupertino {
    _$isCupertinoAtom.reportRead();
    return super.isCupertino;
  }

  @override
  set isCupertino(bool value) {
    _$isCupertinoAtom.reportWrite(value, super.isCupertino, () {
      super.isCupertino = value;
    });
  }

  final _$styleAsyncAction = AsyncAction('_AppControllerBase.style');

  @override
  Future<void> style() {
    return _$styleAsyncAction.run(() => super.style());
  }

  @override
  String toString() {
    return '''
isMaterial: ${isMaterial},
isCupertino: ${isCupertino}
    ''';
  }
}
