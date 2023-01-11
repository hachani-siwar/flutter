import 'package:dartz/dartz.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/domain/repositories/classes_repository.dart';
import 'package:proj/global/error/failures.dart';

class GetAllClassesUsecase {
  final ClassesRepository repository;
  GetAllClassesUsecase(this.repository);
  Future<Either<Failure, List<Classe>>> call() async {
    return await repository.getAllClasses();
  }
}
