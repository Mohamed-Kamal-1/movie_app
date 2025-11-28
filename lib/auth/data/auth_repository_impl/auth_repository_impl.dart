import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/errors/failure.dart';
import '../../domain/auth_repository/auth_repository.dart';
import '../../domain/entities/auth_result.dart';
import '../auth_data_source/AuthDataSourceImpl.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSourceImpl _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<Either<Failure, AuthResult>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    try {
      final result = await _authDataSource.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
        avaterId: avaterId,
      );
      return Right(result.toEntity());
    } on DioException catch (e) {
      // ✅ تأكد من أن الرسالة دايمًا String حتى لو رجعت List
      final error = e.response?.data?["message"];
      String message;

      if (error is List) {
        message = error.join(", "); // دمج عناصر الليست
      } else if (error is String) {
        message = error;
      } else {
        message = "Server error";
      }

      return Left(ServerFailure(message: message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
