//avoid_print

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movieapp/data/core/unauthorised_exception.dart';

import 'package:movieapp/data/data_sources/authentication_local_data_source.dart';
import 'package:movieapp/data/data_sources/authentication_remote_data_source.dart';
import 'package:movieapp/data/models/request_token_model.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationLocalDataSource _authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._authenticationLocalDataSource,
  );

  Future<Either<AppError, RequestTokenModel?>> _getRequestToken() async {
    try {
      final response = await _authenticationRemoteDataSource.getRequestToken();
      print(response.success);
      return Right(response);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String, dynamic> params) async {
    final requestTokenEitherResponse = await _getRequestToken();
    final token1 =
        requestTokenEitherResponse.getOrElse(() => null)?.requestToken ?? '';

    try {
      params.putIfAbsent('request_token', () => token1);
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(params);
      final sessionId = await _authenticationRemoteDataSource
          .createSession(validateWithLoginToken.tojson());
      print('session : $sessionId');
      await _authenticationLocalDataSource.saveSessionId(sessionId);
      return const Right(true);
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    await Future.wait([
      _authenticationRemoteDataSource.deleteSession(sessionId),
      _authenticationLocalDataSource.deleteSessionId(),
    ]);
    print(await _authenticationLocalDataSource.getSessionId());
    return const Right(Unit);
  }
}
