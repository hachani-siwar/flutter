import 'package:dartz/dartz.dart';
import 'package:proj/features/msg/domain/repositories/msg_repository.dart';
import 'package:proj/global/error/failures.dart';

class DeleteMsgUsecase {
  final MsgsRepository repository;
  DeleteMsgUsecase(this.repository);
  Future<Either<Failure, Unit>> call(String MsgId) async {
    return await repository.deleteMsg(MsgId);
  }
}
