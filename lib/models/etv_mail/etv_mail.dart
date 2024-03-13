import 'package:freezed_annotation/freezed_annotation.dart';

part 'etv_mail.freezed.dart';
part 'etv_mail.g.dart';

@freezed
class ETVMail with _$ETVMail {
  factory ETVMail({
    String? $id,
    String? $databaseId,
    String? $collectionId,
    String? $createdAt,
    String? $updatedAt,
    List<String>? $permissions,
    required String address,
  }) = _ETVMail;

  factory ETVMail.fromJson(Map<String, dynamic> json) =>
      _$ETVMailFromJson(json);
}
