// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Schedule.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Schedule on ScheduleBase, Store {
  final _$priceFinalAtom = Atom(name: 'ScheduleBase.priceFinal');

  @override
  double get priceFinal {
    _$priceFinalAtom.context.enforceReadPolicy(_$priceFinalAtom);
    _$priceFinalAtom.reportObserved();
    return super.priceFinal;
  }

  @override
  set priceFinal(double value) {
    _$priceFinalAtom.context.conditionallyRunInAction(() {
      super.priceFinal = value;
      _$priceFinalAtom.reportChanged();
    }, _$priceFinalAtom, name: '${_$priceFinalAtom.name}_set');
  }

  final _$ScheduleBaseActionController = ActionController(name: 'ScheduleBase');

  @override
  dynamic updatePrice(dynamic priceFinalUpdated) {
    final _$actionInfo = _$ScheduleBaseActionController.startAction();
    try {
      return super.updatePrice(priceFinalUpdated);
    } finally {
      _$ScheduleBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'priceFinal: ${priceFinal.toString()}';
    return '{$string}';
  }
}
