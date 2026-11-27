// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_measurements_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BodyMeasurementsState {

 BodyMeasurementsStatus get status; String? get bodyShape; String? get errorMessage;
/// Create a copy of BodyMeasurementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BodyMeasurementsStateCopyWith<BodyMeasurementsState> get copyWith => _$BodyMeasurementsStateCopyWithImpl<BodyMeasurementsState>(this as BodyMeasurementsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BodyMeasurementsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BodyMeasurementsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.bodyShape, _this.bodyShape) || other.bodyShape == _this.bodyShape)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as BodyMeasurementsState;
  return Object.hash(runtimeType,_this.status,_this.bodyShape,_this.errorMessage);
}

@override
String toString() {
  final _this = this as BodyMeasurementsState;
  return 'BodyMeasurementsState(status: ${_this.status}, bodyShape: ${_this.bodyShape}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $BodyMeasurementsStateCopyWith<$Res>  {
  factory $BodyMeasurementsStateCopyWith(BodyMeasurementsState value, $Res Function(BodyMeasurementsState) _then) = _$BodyMeasurementsStateCopyWithImpl;
@useResult
$Res call({
 BodyMeasurementsStatus status, String? bodyShape, String? errorMessage
});




}
/// @nodoc
class _$BodyMeasurementsStateCopyWithImpl<$Res>
    implements $BodyMeasurementsStateCopyWith<$Res> {
  _$BodyMeasurementsStateCopyWithImpl(this._self, this._then);

  final BodyMeasurementsState _self;
  final $Res Function(BodyMeasurementsState) _then;

/// Create a copy of BodyMeasurementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? bodyShape = freezed,Object? errorMessage = freezed,}) {
  return _then(BodyMeasurementsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BodyMeasurementsStatus,bodyShape: freezed == bodyShape ? _self.bodyShape : bodyShape // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BodyMeasurementsState].
extension BodyMeasurementsStatePatterns on BodyMeasurementsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BodyMeasurementsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BodyMeasurementsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BodyMeasurementsState value)  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurementsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BodyMeasurementsState value)?  $default,){
final _that = this;
switch (_that) {
case _BodyMeasurementsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BodyMeasurementsStatus status,  String? bodyShape,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BodyMeasurementsState() when $default != null:
return $default(_that.status,_that.bodyShape,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BodyMeasurementsStatus status,  String? bodyShape,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurementsState():
return $default(_that.status,_that.bodyShape,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BodyMeasurementsStatus status,  String? bodyShape,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BodyMeasurementsState() when $default != null:
return $default(_that.status,_that.bodyShape,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BodyMeasurementsState implements BodyMeasurementsState {
  const _BodyMeasurementsState({this.status = BodyMeasurementsStatus.initial, this.bodyShape, this.errorMessage});
  

@override@JsonKey() final  BodyMeasurementsStatus status;
@override final  String? bodyShape;
@override final  String? errorMessage;

/// Create a copy of BodyMeasurementsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BodyMeasurementsStateCopyWith<_BodyMeasurementsState> get copyWith => __$BodyMeasurementsStateCopyWithImpl<_BodyMeasurementsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BodyMeasurementsState&&(identical(other.status, status) || other.status == status)&&(identical(other.bodyShape, bodyShape) || other.bodyShape == bodyShape)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,bodyShape,errorMessage);
}

@override
String toString() {
    return 'BodyMeasurementsState(status: $status, bodyShape: $bodyShape, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BodyMeasurementsStateCopyWith<$Res> implements $BodyMeasurementsStateCopyWith<$Res> {
  factory _$BodyMeasurementsStateCopyWith(_BodyMeasurementsState value, $Res Function(_BodyMeasurementsState) _then) = __$BodyMeasurementsStateCopyWithImpl;
@override @useResult
$Res call({
 BodyMeasurementsStatus status, String? bodyShape, String? errorMessage
});




}
/// @nodoc
class __$BodyMeasurementsStateCopyWithImpl<$Res>
    implements _$BodyMeasurementsStateCopyWith<$Res> {
  __$BodyMeasurementsStateCopyWithImpl(this._self, this._then);

  final _BodyMeasurementsState _self;
  final $Res Function(_BodyMeasurementsState) _then;

/// Create a copy of BodyMeasurementsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? bodyShape = freezed,Object? errorMessage = freezed,}) {
  return _then(_BodyMeasurementsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BodyMeasurementsStatus,bodyShape: freezed == bodyShape ? _self.bodyShape : bodyShape // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
