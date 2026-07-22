// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailParams {

 String get email; String? get password; String? get confirmPassword;
/// Create a copy of EmailParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailParamsCopyWith<EmailParams> get copyWith => _$EmailParamsCopyWithImpl<EmailParams>(this as EmailParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailParams&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword);

@override
String toString() {
  return 'EmailParams(email: $email, password: $password, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $EmailParamsCopyWith<$Res>  {
  factory $EmailParamsCopyWith(EmailParams value, $Res Function(EmailParams) _then) = _$EmailParamsCopyWithImpl;
@useResult
$Res call({
 String email, String? password, String? confirmPassword
});




}
/// @nodoc
class _$EmailParamsCopyWithImpl<$Res>
    implements $EmailParamsCopyWith<$Res> {
  _$EmailParamsCopyWithImpl(this._self, this._then);

  final EmailParams _self;
  final $Res Function(EmailParams) _then;

/// Create a copy of EmailParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = freezed,Object? confirmPassword = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,confirmPassword: freezed == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailParams].
extension EmailParamsPatterns on EmailParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailParams value)  $default,){
final _that = this;
switch (_that) {
case _EmailParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailParams value)?  $default,){
final _that = this;
switch (_that) {
case _EmailParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String? password,  String? confirmPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailParams() when $default != null:
return $default(_that.email,_that.password,_that.confirmPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String? password,  String? confirmPassword)  $default,) {final _that = this;
switch (_that) {
case _EmailParams():
return $default(_that.email,_that.password,_that.confirmPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String? password,  String? confirmPassword)?  $default,) {final _that = this;
switch (_that) {
case _EmailParams() when $default != null:
return $default(_that.email,_that.password,_that.confirmPassword);case _:
  return null;

}
}

}

/// @nodoc


class _EmailParams implements EmailParams {
  const _EmailParams({required this.email, this.password, this.confirmPassword});
  

@override final  String email;
@override final  String? password;
@override final  String? confirmPassword;

/// Create a copy of EmailParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailParamsCopyWith<_EmailParams> get copyWith => __$EmailParamsCopyWithImpl<_EmailParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailParams&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword);

@override
String toString() {
  return 'EmailParams(email: $email, password: $password, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class _$EmailParamsCopyWith<$Res> implements $EmailParamsCopyWith<$Res> {
  factory _$EmailParamsCopyWith(_EmailParams value, $Res Function(_EmailParams) _then) = __$EmailParamsCopyWithImpl;
@override @useResult
$Res call({
 String email, String? password, String? confirmPassword
});




}
/// @nodoc
class __$EmailParamsCopyWithImpl<$Res>
    implements _$EmailParamsCopyWith<$Res> {
  __$EmailParamsCopyWithImpl(this._self, this._then);

  final _EmailParams _self;
  final $Res Function(_EmailParams) _then;

/// Create a copy of EmailParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = freezed,Object? confirmPassword = freezed,}) {
  return _then(_EmailParams(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,confirmPassword: freezed == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
