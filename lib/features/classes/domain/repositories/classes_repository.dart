import 'package:dartz/dartz.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/global/error/failures.dart';

abstract class ClassesRepository {
  Future<Either<Failure, List<Classe>>> getAllClasses();
  Future<Either<Failure, Unit>> deleteClasse(String id);
  Future<Either<Failure, Unit>> updateClasse(Classe classe);
  Future<Either<Failure, Unit>> addClasse(Classe classe);
}
