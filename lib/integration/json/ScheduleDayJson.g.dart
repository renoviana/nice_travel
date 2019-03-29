// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduleDayJson.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScheduleDayJson> _$scheduleDayJsonSerializer =
    new _$ScheduleDayJsonSerializer();

class _$ScheduleDayJsonSerializer
    implements StructuredSerializer<ScheduleDayJson> {
  @override
  final Iterable<Type> types = const [ScheduleDayJson, _$ScheduleDayJson];
  @override
  final String wireName = 'ScheduleDayJson';

  @override
  Iterable serialize(Serializers serializers, ScheduleDayJson object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.priceDay != null) {
      result
        ..add('priceDay')
        ..add(serializers.serialize(object.priceDay,
            specifiedType: const FullType(double)));
    }
    if (object.day != null) {
      result
        ..add('day')
        ..add(serializers.serialize(object.day,
            specifiedType: const FullType(int)));
    }

    return result;
  }

  @override
  ScheduleDayJson deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleDayJsonBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'priceDay':
          result.priceDay = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleDayJson extends ScheduleDayJson {
  @override
  final double priceDay;
  @override
  final int day;

  factory _$ScheduleDayJson([void updates(ScheduleDayJsonBuilder b)]) =>
      (new ScheduleDayJsonBuilder()..update(updates)).build();

  _$ScheduleDayJson._({this.priceDay, this.day}) : super._();

  @override
  ScheduleDayJson rebuild(void updates(ScheduleDayJsonBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleDayJsonBuilder toBuilder() =>
      new ScheduleDayJsonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleDayJson &&
        priceDay == other.priceDay &&
        day == other.day;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, priceDay.hashCode), day.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScheduleDayJson')
          ..add('priceDay', priceDay)
          ..add('day', day))
        .toString();
  }
}

class ScheduleDayJsonBuilder
    implements Builder<ScheduleDayJson, ScheduleDayJsonBuilder> {
  _$ScheduleDayJson _$v;

  double _priceDay;
  double get priceDay => _$this._priceDay;
  set priceDay(double priceDay) => _$this._priceDay = priceDay;

  int _day;
  int get day => _$this._day;
  set day(int day) => _$this._day = day;

  ScheduleDayJsonBuilder();

  ScheduleDayJsonBuilder get _$this {
    if (_$v != null) {
      _priceDay = _$v.priceDay;
      _day = _$v.day;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleDayJson other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ScheduleDayJson;
  }

  @override
  void update(void updates(ScheduleDayJsonBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ScheduleDayJson build() {
    final _$result =
        _$v ?? new _$ScheduleDayJson._(priceDay: priceDay, day: day);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
