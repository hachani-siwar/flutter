// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:proj/features/msg/data/datasources/msg_local_data_source.dart';
import 'package:proj/features/msg/data/datasources/msg_remote_data_source.dart';
import 'package:proj/features/msg/data/models/msg_model.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/domain/repositories/msg_repository.dart';
import 'package:proj/global/error/exceptions.dart';
import 'package:proj/global/error/failures.dart';
import 'package:proj/global/network/network_pipe.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class MsgsRepositoryImpl implements MsgsRepository {
  final MsgRemoteDataSource remoteDataSource;
  final MsgLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  MsgsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addMsg(Msg msg) async {
    final MsgModel msgModel =
        MsgModel(id: msg.id, title: msg.title, content: msg.content, user: msg.user);
    return _getMessage(() {
      return remoteDataSource.addMsg(msgModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteMsg(String id) async {
    return _getMessage(() {
      return remoteDataSource.deleteMsg(id);
    });
  }

  @override
  Future<Either<Failure, List<Msg>>> getAllMsgs() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMsgs = await remoteDataSource.getAllMsgs();
        return right(remoteMsgs);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localMsgs = await localDataSource.getCachedMsgs();
        return right(localMsgs);
      } on EmpetyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMsg(Msg msg) async {
    final MsgModel msgModel =
        MsgModel(id: msg.id, title: msg.title, content:msg.content,user: msg.user);
    return _getMessage(() {
      return remoteDataSource.updateMsg(msgModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddMsg) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddMsg();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
