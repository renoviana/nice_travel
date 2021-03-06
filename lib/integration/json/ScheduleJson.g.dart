// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduleJson.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ScheduleJson> _$scheduleJsonSerializer =
    new _$ScheduleJsonSerializer();

class _$ScheduleJsonSerializer implements StructuredSerializer<ScheduleJson> {
  @override
  final Iterable<Type> types = const [ScheduleJson, _$ScheduleJson];
  @override
  final String wireName = 'ScheduleJson';

  @override
  Iterable<Object> serialize(Serializers serializers, ScheduleJson object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.scheduleCod != null) {
      result
        ..add('scheduleCod')
        ..add(serializers.serialize(object.scheduleCod,
            specifiedType: const FullType(int)));
    }
    if (object.qtdDays != null) {
      result
        ..add('qtdDays')
        ..add(serializers.serialize(object.qtdDays,
            specifiedType: const FullType(int)));
    }
    if (object.cityAddress != null) {
      result
        ..add('cityAddress')
        ..add(serializers.serialize(object.cityAddress,
            specifiedType: const FullType(String)));
    }
    if (object.priceFinal != null) {
      result
        ..add('priceFinal')
        ..add(serializers.serialize(object.priceFinal,
            specifiedType: const FullType(double)));
    }
    if (object.userUID != null) {
      result
        ..add('userUID')
        ..add(serializers.serialize(object.userUID,
            specifiedType: const FullType(String)));
    }
    if (object.numberStar != null) {
      result
        ..add('numberStar')
        ..add(serializers.serialize(object.numberStar,
            specifiedType: const FullType(int)));
    }
    if (object.userName != null) {
      result
        ..add('userName')
        ..add(serializers.serialize(object.userName,
            specifiedType: const FullType(String)));
    }
    if (object.publish != null) {
      result
        ..add('publish')
        ..add(serializers.serialize(object.publish,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  ScheduleJson deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ScheduleJsonBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'scheduleCod':
          result.scheduleCod = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'qtdDays':
          result.qtdDays = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'cityAddress':
          result.cityAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'priceFinal':
          result.priceFinal = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'userUID':
          result.userUID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'numberStar':
          result.numberStar = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userName':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'publish':
          result.publish = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ScheduleJson extends ScheduleJson {
  @override
  final int scheduleCod;
  @override
  final int qtdDays;
  @override
  final String cityAddress;
  @override
  final double priceFinal;
  @override
  final String userUID;
  @override
  final int numberStar;
  @override
  final String userName;
  @override
  final bool publish;

  factory _$ScheduleJson([void Function(ScheduleJsonBuilder) updates]) =>
      (new ScheduleJsonBuilder()..update(updates)).build();

  _$ScheduleJson._(
      {this.scheduleCod,
      this.qtdDays,
      this.cityAddress,
      this.priceFinal,
      this.userUID,
      this.numberStar,
      this.userName,
      this.publish})
      : super._();

  @override
  ScheduleJson rebuild(void Function(ScheduleJsonBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleJsonBuilder toBuilder() => new ScheduleJsonBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleJson &&
        scheduleCod == other.scheduleCod &&
        qtdDays == other.qtdDays &&
        cityAddress == other.cityAddress &&
        priceFinal == other.priceFinal &&
        userUID == other.userUID &&
        numberStar == other.numberStar &&
        userName == other.userName &&
        publish == other.publish;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, scheduleCod.hashCode), qtdDays.hashCode),
                            cityAddress.hashCode),
                        priceFinal.hashCode),
                    userUID.hashCode),
                numberStar.hashCode),
            userName.hashCode),
        publish.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScheduleJson')
          ..add('scheduleCod', scheduleCod)
          ..add('qtdDays', qtdDays)
          ..add('cityAddress', cityAddress)
          ..add('priceFinal', priceFinal)
          ..add('userUID', userUID)
          ..add('numberStar', numberStar)
          ..add('userName', userName)
          ..add('publish', publish))
        .toString();
  }
}

class ScheduleJsonBuilder
    implements Builder<ScheduleJson, ScheduleJsonBuilder> {
  _$ScheduleJson _$v;

  int _scheduleCod;
  int get scheduleCod => _$this._scheduleCod;
  set scheduleCod(int scheduleCod) => _$this._scheduleCod = scheduleCod;

  int _qtdDays;
  int get qtdDays => _$this._qtdDays;
  set qtdDays(int qtdDays) => _$this._qtdDays = qtdDays;

  String _cityAddress;
  String get cityAddress => _$this._cityAddress;
  set cityAddress(String cityAddress) => _$this._cityAddress = cityAddress;

  double _priceFinal;
  double get priceFinal => _$this._priceFinal;
  set priceFinal(double priceFinal) => _$this._priceFinal = priceFinal;

  String _userUID;
  String get userUID => _$this._userUID;
  set userUID(String userUID) => _$this._userUID = userUID;

  int _numberStar;
  int get numberStar => _$this._numberStar;
  set numberStar(int numberStar) => _$this._numberStar = numberStar;

  String _userName;
  String get userName => _$this._userName;
  set userName(String userName) => _$this._userName = userName;

  bool _publish;
  bool get publish => _$this._publish;
  set publish(bool publish) => _$this._publish = publish;

  ScheduleJsonBuilder();

  ScheduleJsonBuilder get _$this {
    if (_$v != null) {
      _scheduleCod = _$v.scheduleCod;
      _qtdDays = _$v.qtdDays;
      _cityAddress = _$v.cityAddress;
      _priceFinal = _$v.priceFinal;
      _userUID = _$v.userUID;
      _numberStar = _$v.numberStar;
      _userName = _$v.userName;
      _publish = _$v.publish;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleJson other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ScheduleJson;
  }

  @override
  void update(void Function(ScheduleJsonBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ScheduleJson build() {
    final _$result = _$v ??
        new _$ScheduleJson._(
            scheduleCod: scheduleCod,
            qtdDays: qtdDays,
            cityAddress: cityAddress,
            priceFinal: priceFinal,
            userUID: userUID,
            numberStar: numberStar,
            userName: userName,
            publish: publish);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
