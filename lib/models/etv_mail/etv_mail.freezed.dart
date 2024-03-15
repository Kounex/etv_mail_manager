// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'etv_mail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ETVMail _$ETVMailFromJson(Map<String, dynamic> json) {
  return _ETVMail.fromJson(json);
}

/// @nodoc
mixin _$ETVMail {
  String? get $id => throw _privateConstructorUsedError;
  String? get $databaseId => throw _privateConstructorUsedError;
  String? get $collectionId => throw _privateConstructorUsedError;
  String? get $createdAt => throw _privateConstructorUsedError;
  String? get $updatedAt => throw _privateConstructorUsedError;
  List<String>? get $permissions => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  MailType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ETVMailCopyWith<ETVMail> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ETVMailCopyWith<$Res> {
  factory $ETVMailCopyWith(ETVMail value, $Res Function(ETVMail) then) =
      _$ETVMailCopyWithImpl<$Res, ETVMail>;
  @useResult
  $Res call(
      {String? $id,
      String? $databaseId,
      String? $collectionId,
      String? $createdAt,
      String? $updatedAt,
      List<String>? $permissions,
      String address,
      MailType type});
}

/// @nodoc
class _$ETVMailCopyWithImpl<$Res, $Val extends ETVMail>
    implements $ETVMailCopyWith<$Res> {
  _$ETVMailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? $id = freezed,
    Object? $databaseId = freezed,
    Object? $collectionId = freezed,
    Object? $createdAt = freezed,
    Object? $updatedAt = freezed,
    Object? $permissions = freezed,
    Object? address = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      $id: freezed == $id
          ? _value.$id
          : $id // ignore: cast_nullable_to_non_nullable
              as String?,
      $databaseId: freezed == $databaseId
          ? _value.$databaseId
          : $databaseId // ignore: cast_nullable_to_non_nullable
              as String?,
      $collectionId: freezed == $collectionId
          ? _value.$collectionId
          : $collectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      $createdAt: freezed == $createdAt
          ? _value.$createdAt
          : $createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      $updatedAt: freezed == $updatedAt
          ? _value.$updatedAt
          : $updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      $permissions: freezed == $permissions
          ? _value.$permissions
          : $permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MailType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ETVMailImplCopyWith<$Res> implements $ETVMailCopyWith<$Res> {
  factory _$$ETVMailImplCopyWith(
          _$ETVMailImpl value, $Res Function(_$ETVMailImpl) then) =
      __$$ETVMailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? $id,
      String? $databaseId,
      String? $collectionId,
      String? $createdAt,
      String? $updatedAt,
      List<String>? $permissions,
      String address,
      MailType type});
}

/// @nodoc
class __$$ETVMailImplCopyWithImpl<$Res>
    extends _$ETVMailCopyWithImpl<$Res, _$ETVMailImpl>
    implements _$$ETVMailImplCopyWith<$Res> {
  __$$ETVMailImplCopyWithImpl(
      _$ETVMailImpl _value, $Res Function(_$ETVMailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? $id = freezed,
    Object? $databaseId = freezed,
    Object? $collectionId = freezed,
    Object? $createdAt = freezed,
    Object? $updatedAt = freezed,
    Object? $permissions = freezed,
    Object? address = null,
    Object? type = null,
  }) {
    return _then(_$ETVMailImpl(
      $id: freezed == $id
          ? _value.$id
          : $id // ignore: cast_nullable_to_non_nullable
              as String?,
      $databaseId: freezed == $databaseId
          ? _value.$databaseId
          : $databaseId // ignore: cast_nullable_to_non_nullable
              as String?,
      $collectionId: freezed == $collectionId
          ? _value.$collectionId
          : $collectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      $createdAt: freezed == $createdAt
          ? _value.$createdAt
          : $createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      $updatedAt: freezed == $updatedAt
          ? _value.$updatedAt
          : $updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      $permissions: freezed == $permissions
          ? _value._$permissions
          : $permissions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MailType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ETVMailImpl implements _ETVMail {
  _$ETVMailImpl(
      {this.$id,
      this.$databaseId,
      this.$collectionId,
      this.$createdAt,
      this.$updatedAt,
      final List<String>? $permissions,
      required this.address,
      this.type = MailType.active})
      : _$permissions = $permissions;

  factory _$ETVMailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ETVMailImplFromJson(json);

  @override
  final String? $id;
  @override
  final String? $databaseId;
  @override
  final String? $collectionId;
  @override
  final String? $createdAt;
  @override
  final String? $updatedAt;
  final List<String>? _$permissions;
  @override
  List<String>? get $permissions {
    final value = _$permissions;
    if (value == null) return null;
    if (_$permissions is EqualUnmodifiableListView) return _$permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String address;
  @override
  @JsonKey()
  final MailType type;

  @override
  String toString() {
    return 'ETVMail(\$id: ${$id}, \$databaseId: ${$databaseId}, \$collectionId: ${$collectionId}, \$createdAt: ${$createdAt}, \$updatedAt: ${$updatedAt}, \$permissions: ${$permissions}, address: $address, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ETVMailImpl &&
            (identical(other.$id, $id) || other.$id == $id) &&
            (identical(other.$databaseId, $databaseId) ||
                other.$databaseId == $databaseId) &&
            (identical(other.$collectionId, $collectionId) ||
                other.$collectionId == $collectionId) &&
            (identical(other.$createdAt, $createdAt) ||
                other.$createdAt == $createdAt) &&
            (identical(other.$updatedAt, $updatedAt) ||
                other.$updatedAt == $updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._$permissions, _$permissions) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      $id,
      $databaseId,
      $collectionId,
      $createdAt,
      $updatedAt,
      const DeepCollectionEquality().hash(_$permissions),
      address,
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ETVMailImplCopyWith<_$ETVMailImpl> get copyWith =>
      __$$ETVMailImplCopyWithImpl<_$ETVMailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ETVMailImplToJson(
      this,
    );
  }
}

abstract class _ETVMail implements ETVMail {
  factory _ETVMail(
      {final String? $id,
      final String? $databaseId,
      final String? $collectionId,
      final String? $createdAt,
      final String? $updatedAt,
      final List<String>? $permissions,
      required final String address,
      final MailType type}) = _$ETVMailImpl;

  factory _ETVMail.fromJson(Map<String, dynamic> json) = _$ETVMailImpl.fromJson;

  @override
  String? get $id;
  @override
  String? get $databaseId;
  @override
  String? get $collectionId;
  @override
  String? get $createdAt;
  @override
  String? get $updatedAt;
  @override
  List<String>? get $permissions;
  @override
  String get address;
  @override
  MailType get type;
  @override
  @JsonKey(ignore: true)
  _$$ETVMailImplCopyWith<_$ETVMailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
