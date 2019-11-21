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
    if (object.imageUrl != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(object.imageUrl,
            specifiedType: const FullType(String)));
    }
    if (object.nameCity != null) {
      result
        ..add('nameCity')
        ..add(serializers.serialize(object.nameCity,
            specifiedType: const FullType(String)));
    }
    if (object.priceFinal != null) {
      result
        ..add('priceFinal')
        ..add(serializers.serialize(object.priceFinal,
            specifiedType: const FullType(double)));
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
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nameCity':
          result.nameCity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'priceFinal':
          result.priceFinal = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
  final String imageUrl;
  @override
  final String nameCity;
  @override
  final double priceFinal;

  factory _$ScheduleJson([void Function(ScheduleJsonBuilder) updates]) =>
      (new ScheduleJsonBuilder()..update(updates)).build();

  _$ScheduleJson._(
      {this.scheduleCod,
      this.qtdDays,
      this.imageUrl,
      this.nameCity,
      this.priceFinal})
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
        imageUrl == other.imageUrl &&
        nameCity == other.nameCity &&
        priceFinal == other.priceFinal;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, scheduleCod.hashCode), qtdDays.hashCode),
                imageUrl.hashCode),
            nameCity.hashCode),
        priceFinal.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ScheduleJson')
          ..add('scheduleCod', scheduleCod)
          ..add('qtdDays', qtdDays)
          ..add('imageUrl', imageUrl)
          ..add('nameCity', nameCity)
          ..add('priceFinal', priceFinal))
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

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _nameCity;
  String get nameCity => _$this._nameCity;
  set nameCity(String nameCity) => _$this._nameCity = nameCity;

  double _priceFinal;
  double get priceFinal => _$this._priceFinal;
  set priceFinal(double priceFinal) => _$this._priceFinal = priceFinal;

  ScheduleJsonBuilder();

  ScheduleJsonBuilder get _$this {
    if (_$v != null) {
      _scheduleCod = _$v.scheduleCod;
      _qtdDays = _$v.qtdDays;
      _imageUrl = _$v.imageUrl;
      _nameCity = _$v.nameCity;
      _priceFinal = _$v.priceFinal;
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
            imageUrl: imageUrl,
            nameCity: nameCity,
            priceFinal: priceFinal);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
