import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/domain/usecases/get_all_msg.dart';
import 'package:proj/global/error/failures.dart';
import 'package:proj/global/strings/fails.dart';

part 'msg_event.dart';
part 'msg_state.dart';

class MsgsBloc extends Bloc<MsgsEvent, MsgsState> {
  final GetAllMsgsUsecase getAllMsgs;
  MsgsBloc({
    required this.getAllMsgs,
  }) : super(MsgsInitial()) {
    on<MsgsEvent>((event, emit) async {
      if (event is GetAllMsgsEvent) {
        emit(LoadingMsgsState());

        final failureOrMsgs = await getAllMsgs();

        emit(_mapFailureOrMsgState(failureOrMsgs));
      } else if (event is RefreshMsgsEvent) {
        emit(LoadingMsgsState());

        final failureOrMsgs = await getAllMsgs();

        emit(_mapFailureOrMsgState(failureOrMsgs));
      }
    });
  }

  MsgsState _mapFailureOrMsgState(Either<Failure, List<Msg>> either) {
    return either.fold(
      (failure) => ErrorMsgsState(
        message: _mapFailureToMessage(failure),
      ),
      (msgs) => LoadedMsgsState(
        msgs: msgs,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAIL_MESSAGE;

      case EmptyCacheFailure:
        return EMPTY_CACHE_FAIL_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAIL_MESSAGE;

      default:
        return UNEXPECTED_FAIL_MESSAGE;
    }
  }
}
