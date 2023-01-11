// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:proj/features/classes/data/datasources/classe_local_data_source.dart';
import 'package:proj/features/classes/data/datasources/classe_remote_data_source.dart';
import 'package:proj/features/classes/data/models/classe_model.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/domain/repositories/classes_repository.dart';
import 'package:proj/global/error/exceptions.dart';
import 'package:proj/global/error/failures.dart';
import 'package:proj/global/network/network_pipe.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class ClassesRepositoryImpl implements ClassesRepository {
  final ClasseRemoteDataSource remoteDataSource;
  final ClasseLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  ClassesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addClasse(Classe classe) async {
    final ClasseModel classeModel =
        ClasseModel(id: classe.id, name: classe.name, grade: classe.grade);
    return _getMessage(() {
      return remoteDataSource.addClasse(classeModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteClasse(String id) async {
    return _getMessage(() {
      return remoteDataSource.deleteClasse(id);
    });
  }

  @override
  Future<Either<Failure, List<Classe>>> getAllClasses() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClasses = await remoteDataSource.getAllClasses();
        return right(remoteClasses);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localClasses = await localDataSource.getCachedClasses();
        return right(localClasses);
      } on EmpetyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updateClasse(Classe classe) async {
    final ClasseModel classeModel =
        ClasseModel(id: classe.id, name: classe.name, grade: classe.grade);
    return _getMessage(() {
      return remoteDataSource.updateClasse(classeModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddClasse) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddClasse();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
