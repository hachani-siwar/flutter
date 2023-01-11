import 'package:dartz/dartz.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/global/error/failures.dart';

abstract class MsgsRepository {
  Future<Either<Failure, List<Msg>>> getAllMsgs();
  Future<Either<Failure, Unit>> deleteMsg(String id);
  Future<Either<Failure, Unit>> updateMsg(Msg msg);
  Future<Either<Failure, Unit>> addMsg(Msg msg);
}
