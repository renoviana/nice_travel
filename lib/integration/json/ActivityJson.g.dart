// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivityJson.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ActivityJson> _$activityJsonSerializer =
    new _$ActivityJsonSerializer();

class _$ActivityJsonSerializer implements StructuredSerializer<ActivityJson> {
  @override
  final Iterable<Type> types = const [ActivityJson, _$ActivityJson];
  @override
  final String wireName = 'ActivityJson';

  @override
  Iterable<Object> serialize(Serializers serializers, ActivityJson object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.nameOfPlace != null) {
      result
        ..add('nameOfPlace')
        ..add(serializers.serialize(object.nameOfPlace,
            specifiedType: const FullType(String)));
    }
    if (object.price != null) {
      result
        ..add('price')
        ..add(serializers.serialize(object.price,
            specifiedType: const FullType(double)));
    }
    if (object.startActivity != null) {
      result
        ..add('startActivity')
        ..add(serializers.serialize(object.startActivity,
            specifiedType: const FullType(String)));
    }
    if (object.finishActivity != null) {
      result
        ..add('finishActivity')
        ..add(serializers.serialize(object.finishActivity,
            specifiedType: const FullType(String)));
    }
    if (object.styleActivity != null) {
      result
        ..add('styleActivity')
        ..add(serializers.serialize(object.styleActivity,
            specifiedType: const FullType(String)));
    }
    if (object.idScheduleDay != null) {
      result
        ..add('idScheduleDay')
        ..add(serializers.serialize(object.idScheduleDay,
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
  ActivityJson deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ActivityJsonBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nameOfPlace':
          result.nameOfPlace = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'startActivity':
          result.startActivity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'finishActivity':
          result.finishActivity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'styleActivity':
          result.styleActivity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'idScheduleDay':
          result.idScheduleDay = serializers.deserialize(value,
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

class _$ActivityJson extends ActivityJson {
  @override
  final String description;
  @override
  final String nameOfPlace;
  @override
  final double price;
  @override
  final String startActivity;
  @override
  final String finishActivity;
  @override
  final String styleActivity;
  @override
  final int idScheduleDay;
  @override
  final int id;

  factory _$ActivityJson([void Function(ActivityJsonBuilder) updates]) =>
      (new ActivityJsonBuilder()..update(updates)).build();

  _$ActivityJson._(
      {this.description,
      this.nameOfPlace,
      this.price,
      this.startActivity,
      this.finishActivity,
      this.styleActivity,
      this.idScheduleDay,
      this.id})
      : super._();

  @override
  ActivityJson rebuild(void Function(ActivityJsonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityJsonBuilder toBuilder() => new ActivityJsonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityJson &&
        description == other.description &&
        nameOfPlace == other.nameOfPlace &&
        price == other.price &&
        startActivity == other.startActivity &&
        finishActivity == other.finishActivity &&
        styleActivity == other.styleActivity &&
        idScheduleDay == other.idScheduleDay &&
        id == other.id;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, description.hashCode),
                                nameOfPlace.hashCode),
                            price.hashCode),
                        startActivity.hashCode),
                    finishActivity.hashCode),
                styleActivity.hashCode),
            idScheduleDay.hashCode),
        id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ActivityJson')
          ..add('description', description)
          ..add('nameOfPlace', nameOfPlace)
          ..add('price', price)
          ..add('startActivity', startActivity)
          ..add('finishActivity', finishActivity)
          ..add('styleActivity', styleActivity)
          ..add('idScheduleDay', idScheduleDay)
          ..add('id', id))
        .toString();
  }
}

class ActivityJsonBuilder
    implements Builder<ActivityJson, ActivityJsonBuilder> {
  _$ActivityJson _$v;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _nameOfPlace;
  String get nameOfPlace => _$this._nameOfPlace;
  set nameOfPlace(String nameOfPlace) => _$this._nameOfPlace = nameOfPlace;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  String _startActivity;
  String get startActivity => _$this._startActivity;
  set startActivity(String startActivity) =>
      _$this._startActivity = startActivity;

  String _finishActivity;
  String get finishActivity => _$this._finishActivity;
  set finishActivity(String finishActivity) =>
      _$this._finishActivity = finishActivity;

  String _styleActivity;
  String get styleActivity => _$this._styleActivity;
  set styleActivity(String styleActivity) =>
      _$this._styleActivity = styleActivity;

  int _idScheduleDay;
  int get idScheduleDay => _$this._idScheduleDay;
  set idScheduleDay(int idScheduleDay) => _$this._idScheduleDay = idScheduleDay;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  ActivityJsonBuilder();

  ActivityJsonBuilder get _$this {
    if (_$v != null) {
      _description = _$v.description;
      _nameOfPlace = _$v.nameOfPlace;
      _price = _$v.price;
      _startActivity = _$v.startActivity;
      _finishActivity = _$v.finishActivity;
      _styleActivity = _$v.styleActivity;
      _idScheduleDay = _$v.idScheduleDay;
      _id = _$v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityJson other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ActivityJson;
  }

  @override
  void update(void Function(ActivityJsonBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ActivityJson build() {
    final _$result = _$v ??
        new _$ActivityJson._(
            description: description,
            nameOfPlace: nameOfPlace,
            price: price,
            startActivity: startActivity,
            finishActivity: finishActivity,
            styleActivity: styleActivity,
            idScheduleDay: idScheduleDay,
            id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
