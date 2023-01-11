import 'package:dartz/dartz.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/domain/repositories/msg_repository.dart';
import 'package:proj/global/error/failures.dart';

class UpdateMsgUsecase {
  final MsgsRepository repository;
  UpdateMsgUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Msg msgToUpdate) async {
    return await repository.updateMsg(msgToUpdate);
  }
}
