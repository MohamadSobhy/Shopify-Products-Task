import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../constants/constant_values.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../network/network_info.dart';

/// [RepositoryCallHandler] is a handler class used to handle all the repositories
/// methods calls through the whole project.
///
/// it has a [handleCall] method that returns the result of the method call when there is no
/// [Exception] happens.
class RepositoryCallHandler {
  final NetworkInfo networkInfo;

  RepositoryCallHandler({required this.networkInfo});

  /// handles all types of [Exception]s that may happen through the whole project.
  ///
  /// accepts a function call as an argument [methodCall]
  ///
  /// returns the result of the [methodCall] when there is no [Exception] happens.
  Future<Either<Failure, T>> handleCall<T>(dynamic methodCall) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await methodCall();

        return Right(result);
      } on ServerException catch (err) {
        return Left(ServerFailure(message: err.message));
      } on SocketException catch (_) {
        return const Left(
          NetworkFailure(message: ConstantValues.NO_INTERNET_MSG),
        );
      } on NetworkException catch (_) {
        return const Left(
          NetworkFailure(message: ConstantValues.NO_INTERNET_MSG),
        );
      } catch (err) {
        log(err.toString(), name: 'API_BASE_HANDLER');

        return Left(ServerFailure(message: err.toString()));
      }
    } else {
      return const Left(
        NetworkFailure(message: ConstantValues.NO_INTERNET_MSG),
      );
    }
  }
}
