import 'package:dartz/dartz.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/domain/repositories/msg_repository.dart';
import 'package:proj/global/error/failures.dart';

class GetAllMsgsUsecase {
  final MsgsRepository repository;
  GetAllMsgsUsecase(this.repository);
  Future<Either<Failure, List<Msg>>> call() async {
    return await repository.getAllMsgs();
  }
}
