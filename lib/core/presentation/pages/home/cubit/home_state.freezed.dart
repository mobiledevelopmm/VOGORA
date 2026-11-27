// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 HomeStatus get status; List<OutfitItem> get styledOutfits; List<OutfitItem> get trendingOutfits; String get selectedCategory; String? get errorMessage;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.styledOutfits, _this.styledOutfits)&&const DeepCollectionEquality().equals(other.trendingOutfits, _this.trendingOutfits)&&(identical(other.selectedCategory, _this.selectedCategory) || other.selectedCategory == _this.selectedCategory)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as HomeState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.styledOutfits),const DeepCollectionEquality().hash(_this.trendingOutfits),_this.selectedCategory,_this.errorMessage);
}

@override
String toString() {
  final _this = this as HomeState;
  return 'HomeState(status: ${_this.status}, styledOutfits: ${_this.styledOutfits}, trendingOutfits: ${_this.trendingOutfits}, selectedCategory: ${_this.selectedCategory}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 HomeStatus status, List<OutfitItem> styledOutfits, List<OutfitItem> trendingOutfits, String selectedCategory, String? errorMessage
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? styledOutfits = null,Object? trendingOutfits = null,Object? selectedCategory = null,Object? errorMessage = freezed,}) {
  return _then(HomeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HomeStatus,styledOutfits: null == styledOutfits ? _self.styledOutfits : styledOutfits // ignore: cast_nullable_to_non_nullable
as List<OutfitItem>,trendingOutfits: null == trendingOutfits ? _self.trendingOutfits : trendingOutfits // ignore: cast_nullable_to_non_nullable
as List<OutfitItem>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeStatus status,  List<OutfitItem> styledOutfits,  List<OutfitItem> trendingOutfits,  String selectedCategory,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.status,_that.styledOutfits,_that.trendingOutfits,_that.selectedCategory,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeStatus status,  List<OutfitItem> styledOutfits,  List<OutfitItem> trendingOutfits,  String selectedCategory,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.status,_that.styledOutfits,_that.trendingOutfits,_that.selectedCategory,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeStatus status,  List<OutfitItem> styledOutfits,  List<OutfitItem> trendingOutfits,  String selectedCategory,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.status,_that.styledOutfits,_that.trendingOutfits,_that.selectedCategory,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.status = HomeStatus.initial,  List<OutfitItem> styledOutfits = const [],  List<OutfitItem> trendingOutfits = const [], this.selectedCategory = 'Casual', this.errorMessage}): _styledOutfits = styledOutfits,_trendingOutfits = trendingOutfits;
  

@override@JsonKey() final  HomeStatus status;
 final  List<OutfitItem> _styledOutfits;
@override@JsonKey() List<OutfitItem> get styledOutfits {
  if (_styledOutfits is EqualUnmodifiableListView) return _styledOutfits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_styledOutfits);
}

 final  List<OutfitItem> _trendingOutfits;
@override@JsonKey() List<OutfitItem> get trendingOutfits {
  if (_trendingOutfits is EqualUnmodifiableListView) return _trendingOutfits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trendingOutfits);
}

@override@JsonKey() final  String selectedCategory;
@override final  String? errorMessage;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.styledOutfits, _styledOutfits)&&const DeepCollectionEquality().equals(other.trendingOutfits, _trendingOutfits)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_styledOutfits),const DeepCollectionEquality().hash(_trendingOutfits),selectedCategory,errorMessage);
}

@override
String toString() {
    return 'HomeState(status: $status, styledOutfits: $styledOutfits, trendingOutfits: $trendingOutfits, selectedCategory: $selectedCategory, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 HomeStatus status, List<OutfitItem> styledOutfits, List<OutfitItem> trendingOutfits, String selectedCategory, String? errorMessage
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? styledOutfits = null,Object? trendingOutfits = null,Object? selectedCategory = null,Object? errorMessage = freezed,}) {
  return _then(_HomeState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HomeStatus,styledOutfits: null == styledOutfits ? _self._styledOutfits : styledOutfits // ignore: cast_nullable_to_non_nullable
as List<OutfitItem>,trendingOutfits: null == trendingOutfits ? _self._trendingOutfits : trendingOutfits // ignore: cast_nullable_to_non_nullable
as List<OutfitItem>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
