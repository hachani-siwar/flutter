import 'package:dartz/dartz.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/domain/repositories/classes_repository.dart';
import 'package:proj/global/error/failures.dart';

class AddClasseUsecase {
  final ClassesRepository repository;
  AddClasseUsecase(this.repository);
  Future<Either<Failure, Unit>> call(Classe classeToUpdate) async {
    return await repository.addClasse(classeToUpdate);
  }
}
