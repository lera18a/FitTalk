// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FirstNameChanged value)?  firstNameChanged,TResult Function( _UsernameChanged value)?  usernameChanged,TResult Function( _AvatarChanged value)?  avatarChanged,TResult Function( _SaveProfileSubmitted value)?  saveProfileSubmitted,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that);case _UsernameChanged() when usernameChanged != null:
return usernameChanged(_that);case _AvatarChanged() when avatarChanged != null:
return avatarChanged(_that);case _SaveProfileSubmitted() when saveProfileSubmitted != null:
return saveProfileSubmitted(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FirstNameChanged value)  firstNameChanged,required TResult Function( _UsernameChanged value)  usernameChanged,required TResult Function( _AvatarChanged value)  avatarChanged,required TResult Function( _SaveProfileSubmitted value)  saveProfileSubmitted,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _FirstNameChanged():
return firstNameChanged(_that);case _UsernameChanged():
return usernameChanged(_that);case _AvatarChanged():
return avatarChanged(_that);case _SaveProfileSubmitted():
return saveProfileSubmitted(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FirstNameChanged value)?  firstNameChanged,TResult? Function( _UsernameChanged value)?  usernameChanged,TResult? Function( _AvatarChanged value)?  avatarChanged,TResult? Function( _SaveProfileSubmitted value)?  saveProfileSubmitted,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that);case _UsernameChanged() when usernameChanged != null:
return usernameChanged(_that);case _AvatarChanged() when avatarChanged != null:
return avatarChanged(_that);case _SaveProfileSubmitted() when saveProfileSubmitted != null:
return saveProfileSubmitted(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String firstName)?  firstNameChanged,TResult Function( String username)?  usernameChanged,TResult Function( Uint8List? avatarBytes)?  avatarChanged,TResult Function()?  saveProfileSubmitted,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that.firstName);case _UsernameChanged() when usernameChanged != null:
return usernameChanged(_that.username);case _AvatarChanged() when avatarChanged != null:
return avatarChanged(_that.avatarBytes);case _SaveProfileSubmitted() when saveProfileSubmitted != null:
return saveProfileSubmitted();case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String firstName)  firstNameChanged,required TResult Function( String username)  usernameChanged,required TResult Function( Uint8List? avatarBytes)  avatarChanged,required TResult Function()  saveProfileSubmitted,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _FirstNameChanged():
return firstNameChanged(_that.firstName);case _UsernameChanged():
return usernameChanged(_that.username);case _AvatarChanged():
return avatarChanged(_that.avatarBytes);case _SaveProfileSubmitted():
return saveProfileSubmitted();case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String firstName)?  firstNameChanged,TResult? Function( String username)?  usernameChanged,TResult? Function( Uint8List? avatarBytes)?  avatarChanged,TResult? Function()?  saveProfileSubmitted,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that.firstName);case _UsernameChanged() when usernameChanged != null:
return usernameChanged(_that.username);case _AvatarChanged() when avatarChanged != null:
return avatarChanged(_that.avatarBytes);case _SaveProfileSubmitted() when saveProfileSubmitted != null:
return saveProfileSubmitted();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _FirstNameChanged implements ProfileEvent {
  const _FirstNameChanged(this.firstName);
  

 final  String firstName;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirstNameChangedCopyWith<_FirstNameChanged> get copyWith => __$FirstNameChangedCopyWithImpl<_FirstNameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirstNameChanged&&(identical(other.firstName, firstName) || other.firstName == firstName));
}


@override
int get hashCode => Object.hash(runtimeType,firstName);

@override
String toString() {
  return 'ProfileEvent.firstNameChanged(firstName: $firstName)';
}


}

/// @nodoc
abstract mixin class _$FirstNameChangedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$FirstNameChangedCopyWith(_FirstNameChanged value, $Res Function(_FirstNameChanged) _then) = __$FirstNameChangedCopyWithImpl;
@useResult
$Res call({
 String firstName
});




}
/// @nodoc
class __$FirstNameChangedCopyWithImpl<$Res>
    implements _$FirstNameChangedCopyWith<$Res> {
  __$FirstNameChangedCopyWithImpl(this._self, this._then);

  final _FirstNameChanged _self;
  final $Res Function(_FirstNameChanged) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,}) {
  return _then(_FirstNameChanged(
null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UsernameChanged implements ProfileEvent {
  const _UsernameChanged(this.username);
  

 final  String username;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsernameChangedCopyWith<_UsernameChanged> get copyWith => __$UsernameChangedCopyWithImpl<_UsernameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsernameChanged&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'ProfileEvent.usernameChanged(username: $username)';
}


}

/// @nodoc
abstract mixin class _$UsernameChangedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$UsernameChangedCopyWith(_UsernameChanged value, $Res Function(_UsernameChanged) _then) = __$UsernameChangedCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class __$UsernameChangedCopyWithImpl<$Res>
    implements _$UsernameChangedCopyWith<$Res> {
  __$UsernameChangedCopyWithImpl(this._self, this._then);

  final _UsernameChanged _self;
  final $Res Function(_UsernameChanged) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_UsernameChanged(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AvatarChanged implements ProfileEvent {
  const _AvatarChanged(this.avatarBytes);
  

 final  Uint8List? avatarBytes;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvatarChangedCopyWith<_AvatarChanged> get copyWith => __$AvatarChangedCopyWithImpl<_AvatarChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvatarChanged&&const DeepCollectionEquality().equals(other.avatarBytes, avatarBytes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(avatarBytes));

@override
String toString() {
  return 'ProfileEvent.avatarChanged(avatarBytes: $avatarBytes)';
}


}

/// @nodoc
abstract mixin class _$AvatarChangedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory _$AvatarChangedCopyWith(_AvatarChanged value, $Res Function(_AvatarChanged) _then) = __$AvatarChangedCopyWithImpl;
@useResult
$Res call({
 Uint8List? avatarBytes
});




}
/// @nodoc
class __$AvatarChangedCopyWithImpl<$Res>
    implements _$AvatarChangedCopyWith<$Res> {
  __$AvatarChangedCopyWithImpl(this._self, this._then);

  final _AvatarChanged _self;
  final $Res Function(_AvatarChanged) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? avatarBytes = freezed,}) {
  return _then(_AvatarChanged(
freezed == avatarBytes ? _self.avatarBytes : avatarBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,
  ));
}


}

/// @nodoc


class _SaveProfileSubmitted implements ProfileEvent {
  const _SaveProfileSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveProfileSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.saveProfileSubmitted()';
}


}




/// @nodoc


class _Reset implements ProfileEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.reset()';
}


}




/// @nodoc
mixin _$ProfileState {

 String get firstName; String get username; Uint8List? get avatarBytes; ProfileSetupStatus get status; String? get errorMessage;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.username, username) || other.username == username)&&const DeepCollectionEquality().equals(other.avatarBytes, avatarBytes)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,firstName,username,const DeepCollectionEquality().hash(avatarBytes),status,errorMessage);

@override
String toString() {
  return 'ProfileState(firstName: $firstName, username: $username, avatarBytes: $avatarBytes, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 String firstName, String username, Uint8List? avatarBytes, ProfileSetupStatus status, String? errorMessage
});




}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? username = null,Object? avatarBytes = freezed,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(ProfileState(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,avatarBytes: freezed == avatarBytes ? _self.avatarBytes : avatarBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileSetupStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
