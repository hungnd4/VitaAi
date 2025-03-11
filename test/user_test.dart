import 'package:flutter_base_bloc/core/exception/exception.dart';
import 'package:flutter_base_bloc/data/repository_impl/repo_impl.dart';
import 'package:flutter_base_bloc/data/request/find_user_request.dart';
import 'package:flutter_base_bloc/data/response/response_wrapper.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/data/services/user_service.dart';
import 'package:flutter_base_bloc/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserService>()])
void main() {
  late UserRepoImpl repo;
  late MockUserService service;
  setUp(() {
    service = MockUserService();
    repo = UserRepoImpl(service);
  });

  test('getUser successfully test', () async {
    // Arrange
    const req = FindUserRequest(keyword: '');
    const expectResult = Result.success(UserModel());
    //Act
    when(service.getUser(req)).thenAnswer(
      (_) async => const ResponseWrapper<UserModel>(
        data: UserModel(),
      ),
    );

    final res = await repo.getUser(req);
    //Assert
    expect(expectResult, res);
  });

  test('getUser fail test', () async {
    // Arrange
    const req = FindUserRequest(keyword: '');
    const expectErr = UnCatchException();
    //Act
    when(service.getUser(req)).thenThrow(expectErr);

    final res = await repo.getUser(req);
    //Assert
    expect(res, const Result<UserModel>.error(expectErr));
  });
}
