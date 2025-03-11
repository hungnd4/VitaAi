import 'package:flutter_base_bloc/core/exception/exception.dart';
import 'package:flutter_base_bloc/data/repository_impl/repo_impl.dart';
import 'package:flutter_base_bloc/data/request/login_request.dart';
import 'package:flutter_base_bloc/data/response/response_wrapper.dart';
import 'package:flutter_base_bloc/core/result/result.dart';
import 'package:flutter_base_bloc/data/services/login_service.dart';
import 'package:flutter_base_bloc/domain/entities/login.dart';
import 'package:flutter_base_bloc/utils/validator/validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginService>()])
void main() {
  late LoginRepoImpl loginRepo;
  late MockLoginService service;

  setUp(() {
    service = MockLoginService();
    loginRepo = LoginRepoImpl(service);
  });

  bool validate(String? email, String? password) {
    return Validator.emailValidate(email) == null &&
        Validator.passwordValidate(password) == null;
  }

  test('login should return false when the email is empty', () {
    // Arrange
    String? email;
    String password = 'password123';

    // Act
    bool result = validate(email, password);

    // Assert
    expect(result, false);
  });

  test('login should return false when the password is empty', () {
    // Arrange
    String email = 'ntminh@gmail.vn';
    String? password;

    // Act
    bool result = validate(email, password);

    // Assert
    expect(result, false);
  });

  test('login should return false when the email and password are empty', () {
    // Arrange
    String? email;
    String? password;

    // Act
    bool result = validate(email, password);

    // Assert
    expect(result, false);
  });

  test('Repo test with result success', () async {
    // Arrange
    const request =
        LoginRequest(email: 'test@email.com', password: 'validPassword');

    const expectedResult =
        LoginModel(accessToken: 'token', refreshToken: 'refreshToken');
    // Act
    when(service.login(request)).thenAnswer(
      (_) async => const ResponseWrapper(data: expectedResult),
    );
    final response = await loginRepo.login(request);

    // Assert
    expect(response, const Result.success(expectedResult));
  });

  test('Repo test with result Exception', () async {
    // Arrange
    const request =
        LoginRequest(email: 'test@email.com', password: 'validPassword');

    const expectedResult = UnCatchException();
    // Act
    when(service.login(request)).thenThrow(expectedResult);
    final response = await loginRepo.login(request);

    // Assert
    expect(response, const Result<LoginModel>.error(expectedResult));
  });
}
