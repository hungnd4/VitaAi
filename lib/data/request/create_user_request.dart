import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_request.g.dart';
part 'create_user_request.freezed.dart';

@freezed
class RegistrationRequest with _$RegistrationRequest {
  const RegistrationRequest._();
  const factory RegistrationRequest({
    @JsonKey(name: 'username') @Default('') String userName,
    @Default('') String email,
    @Default('') String name,
    @Default('') String password,
    int? age,
  }) = _RegistrationRequest;

  factory RegistrationRequest.fromJson(Map<String, Object?> json) =>
      _$RegistrationRequestFromJson(json);

  bool get isEmpty {
    return email.isEmpty && name.isEmpty && password.isEmpty;
  }
}
