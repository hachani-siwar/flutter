import 'package:dartz/dartz.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/domain/repositories/classes_repository.dart';
import 'package:proj/global/error/failures.dart';

class UpdateClasseUsecase {
  final ClassesRepository repository;
  UpdateClasseUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Classe classeToUpdate) async {
    return await repository.updateClasse(classeToUpdate);
  }
}
