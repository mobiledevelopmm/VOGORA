// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choose_undertone_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChooseUndertoneState {

 ChooseUndertoneStatus get status; String? get selectedUndertone; String? get errorMessage;
/// Create a copy of ChooseUndertoneState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChooseUndertoneStateCopyWith<ChooseUndertoneState> get copyWith => _$ChooseUndertoneStateCopyWithImpl<ChooseUndertoneState>(this as ChooseUndertoneState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChooseUndertoneState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseUndertoneState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.selectedUndertone, _this.selectedUndertone) || other.selectedUndertone == _this.selectedUndertone)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as ChooseUndertoneState;
  return Object.hash(runtimeType,_this.status,_this.selectedUndertone,_this.errorMessage);
}

@override
String toString() {
  final _this = this as ChooseUndertoneState;
  return 'ChooseUndertoneState(status: ${_this.status}, selectedUndertone: ${_this.selectedUndertone}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $ChooseUndertoneStateCopyWith<$Res>  {
  factory $ChooseUndertoneStateCopyWith(ChooseUndertoneState value, $Res Function(ChooseUndertoneState) _then) = _$ChooseUndertoneStateCopyWithImpl;
@useResult
$Res call({
 ChooseUndertoneStatus status, String? selectedUndertone, String? errorMessage
});




}
/// @nodoc
class _$ChooseUndertoneStateCopyWithImpl<$Res>
    implements $ChooseUndertoneStateCopyWith<$Res> {
  _$ChooseUndertoneStateCopyWithImpl(this._self, this._then);

  final ChooseUndertoneState _self;
  final $Res Function(ChooseUndertoneState) _then;

/// Create a copy of ChooseUndertoneState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? selectedUndertone = freezed,Object? errorMessage = freezed,}) {
  return _then(ChooseUndertoneState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChooseUndertoneStatus,selectedUndertone: freezed == selectedUndertone ? _self.selectedUndertone : selectedUndertone // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChooseUndertoneState].
extension ChooseUndertoneStatePatterns on ChooseUndertoneState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChooseUndertoneState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChooseUndertoneState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChooseUndertoneState value)  $default,){
final _that = this;
switch (_that) {
case _ChooseUndertoneState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChooseUndertoneState value)?  $default,){
final _that = this;
switch (_that) {
case _ChooseUndertoneState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChooseUndertoneStatus status,  String? selectedUndertone,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChooseUndertoneState() when $default != null:
return $default(_that.status,_that.selectedUndertone,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChooseUndertoneStatus status,  String? selectedUndertone,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ChooseUndertoneState():
return $default(_that.status,_that.selectedUndertone,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChooseUndertoneStatus status,  String? selectedUndertone,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChooseUndertoneState() when $default != null:
return $default(_that.status,_that.selectedUndertone,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChooseUndertoneState implements ChooseUndertoneState {
  const _ChooseUndertoneState({this.status = ChooseUndertoneStatus.initial, this.selectedUndertone, this.errorMessage});
  

@override@JsonKey() final  ChooseUndertoneStatus status;
@override final  String? selectedUndertone;
@override final  String? errorMessage;

/// Create a copy of ChooseUndertoneState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChooseUndertoneStateCopyWith<_ChooseUndertoneState> get copyWith => __$ChooseUndertoneStateCopyWithImpl<_ChooseUndertoneState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChooseUndertoneState&&(identical(other.status, status) || other.status == status)&&(identical(other.selectedUndertone, selectedUndertone) || other.selectedUndertone == selectedUndertone)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,selectedUndertone,errorMessage);
}

@override
String toString() {
    return 'ChooseUndertoneState(status: $status, selectedUndertone: $selectedUndertone, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ChooseUndertoneStateCopyWith<$Res> implements $ChooseUndertoneStateCopyWith<$Res> {
  factory _$ChooseUndertoneStateCopyWith(_ChooseUndertoneState value, $Res Function(_ChooseUndertoneState) _then) = __$ChooseUndertoneStateCopyWithImpl;
@override @useResult
$Res call({
 ChooseUndertoneStatus status, String? selectedUndertone, String? errorMessage
});




}
/// @nodoc
class __$ChooseUndertoneStateCopyWithImpl<$Res>
    implements _$ChooseUndertoneStateCopyWith<$Res> {
  __$ChooseUndertoneStateCopyWithImpl(this._self, this._then);

  final _ChooseUndertoneState _self;
  final $Res Function(_ChooseUndertoneState) _then;

/// Create a copy of ChooseUndertoneState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? selectedUndertone = freezed,Object? errorMessage = freezed,}) {
  return _then(_ChooseUndertoneState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChooseUndertoneStatus,selectedUndertone: freezed == selectedUndertone ? _self.selectedUndertone : selectedUndertone // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
