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
  Iterable<Object> serialize(Serializers serializers, ScheduleDayJson object,
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
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  ScheduleDayJson deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
        case 'id':
          result.id = serializers.deserialize(value,
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
  @override
  final int id;

  factory _$ScheduleDayJson([void Function(ScheduleDayJsonBuilder) updates]) =>
      (new ScheduleDayJsonBuilder()..update(updates)).build();

  _$ScheduleDayJson._({this.priceDay, this.day, this.id}) : super._();

  @override
  ScheduleDayJson rebuild(void Function(ScheduleDayJsonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleDayJsonBuilder toBuilder() =>
      new ScheduleDayJsonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleDayJson &&
        priceDay == other.priceDay &&
        day == other.day &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, priceDay.hashCode), day.hashCode), id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScheduleDayJson')
          ..add('priceDay', priceDay)
          ..add('day', day)
          ..add('id', id))
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

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ScheduleDayJsonBuilder();

  ScheduleDayJsonBuilder get _$this {
    if (_$v != null) {
      _priceDay = _$v.priceDay;
      _day = _$v.day;
      _id = _$v.id;
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
  void update(void Function(ScheduleDayJsonBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ScheduleDayJson build() {
    final _$result =
        _$v ?? new _$ScheduleDayJson._(priceDay: priceDay, day: day, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
