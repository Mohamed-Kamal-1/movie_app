import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/auth/data/auth_data_source/AuthDataSourceImpl.dart';
import 'package:movie_app/auth/domain/auth_repository/auth_repository.dart';
import 'package:movie_app/auth/domain/entities/auth_result.dart';
import 'package:movie_app/core/errors/failure.dart';

@lazySingleton
class AuthRepositoryImpl implements AuthRepository {
  AuthDataSourceImpl _authDataSource;

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
      return Left(ServerFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(ServerFailure(message: 'error'));
    }
  }
}
