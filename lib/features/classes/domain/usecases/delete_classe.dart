import 'package:dartz/dartz.dart';
import 'package:proj/features/classes/domain/repositories/classes_repository.dart';
import 'package:proj/global/error/failures.dart';

class DeleteClasseUsecase {
  final ClassesRepository repository;
  DeleteClasseUsecase(this.repository);
  Future<Either<Failure, Unit>> call(String ClasseId) async {
    return await repository.deleteClasse(ClasseId);
  }
}
