import 'package:dartz/dartz.dart';
import 'package:logic/core/error/error.dart';
import 'package:logic/domain/entities/dhikr/dhikr_entity.dart';
import 'package:logic/domain/repositories/dhikr/dhikr_repository.dart';

class DhikrUsecases {
  final IDhikrRepository _dhikrRepository;
  DhikrUsecases(this._dhikrRepository);

  Future<Either<SystemError, DhikrEntity>> getDhikr({
    required int dhikrId,
  }) async {
    try {
      return right(await _dhikrRepository.getDhikr(dhikrId: dhikrId));
    } catch (e, s) {
      return left(
        GenericError(
          devErrorMessage: '$e',
          userFriendlyDevErrorMessage: 'unable to get dhikr',
          stackTrace: '$s',
        ),
      );
    }
  }

  Future<Either<SystemError, List<DhikrEntity>>> getDhikrs() async {
    try {
      return right(await _dhikrRepository.getDhikrs());
    } catch (e, s) {
      return left(
        GenericError(
          devErrorMessage: '$e',
          userFriendlyDevErrorMessage: 'unable to get dhikrs',
          stackTrace: '$s',
        ),
      );
    }
  }

  Future<Either<SystemError, bool>> subscribeToDhikr({
    required int dhikrId,
    DateTime? reminderAt,
    required String userToken,
  }) async {
    try {
      return right(
        await _dhikrRepository.subscribeToDhikr(
          dhikrId: dhikrId,
          reminderAt: reminderAt,
          userToken: userToken,
        ),
      );
    } catch (e, s) {
      return left(
        GenericError(
          devErrorMessage: '$e',
          userFriendlyDevErrorMessage: 'unable to subscribe',
          stackTrace: '$s',
        ),
      );
    }
  }

  Future<Either<SystemError, bool>> unSubscribeToDhikr({
    required int dhikrId,
    required String userToken,
  }) async {
    try {
      return right(
        await _dhikrRepository.unSubscribeToDhikr(
          dhikrId: dhikrId,
          userToken: userToken,
        ),
      );
    } catch (e, s) {
      return left(
        GenericError(
          devErrorMessage: '$e',
          userFriendlyDevErrorMessage: 'unable to unsubscribe',
          stackTrace: '$s',
        ),
      );
    }
  }
}
