import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_user_request.g.dart';
part 'find_user_request.freezed.dart';

@freezed
class FindUserRequest with _$FindUserRequest {
  const factory FindUserRequest({required String keyword}) = _FindUserRequest;

  factory FindUserRequest.fromJson(Map<String, Object?> json) =>
      _$FindUserRequestFromJson(json);
}
