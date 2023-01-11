import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/domain/usecases/add_msg.dart';
import 'package:proj/features/msg/domain/usecases/delete_msg.dart';
import 'package:proj/features/msg/domain/usecases/update_msg.dart';
import 'package:proj/global/error/failures.dart';
import 'package:proj/global/strings/fails.dart';
import 'package:proj/global/strings/messages.dart';

part 'msg_crud_event.dart';
part 'msg_crud_state.dart';

class MsgCrudBloc extends Bloc<MsgCrudEvent, MsgCrudState> {
  MsgCrudBloc(
      {required this.addMsg,
      required this.deleteMsg,
      required this.updateMsg})
      : super(MsgCrudInitial()) {
    on<MsgCrudEvent>((event, emit) async {
      if (event is AddMsgEvent) {
        emit(LoadingMsgCrudState());
        final failOrDoneMessage = await addMsg(event.msg);
        emit(_eitherDoneOrErrorMessage(failOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateMsgEvent) {
        emit(LoadingMsgCrudState());
        final failOrDoneMessage = await updateMsg(event.msg);
        emit(_eitherDoneOrErrorMessage(
            failOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeleteMsgEvent) {
        emit(LoadingMsgCrudState());
        final failOrDoneMessage = await deleteMsg(event.msgId);
        emit(_eitherDoneOrErrorMessage(
            failOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  final AddMsgUsecase addMsg;
  final DeleteMsgUsecase deleteMsg;
  final UpdateMsgUsecase updateMsg;

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAIL_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAIL_MESSAGE;

      default:
        return UNEXPECTED_FAIL_MESSAGE;
    }
  }

  MsgCrudState _eitherDoneOrErrorMessage(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) =>
            ErrorMsgCrudState(message: _mapFailureToMessage(failure)),
        (_) => MessageMsgCrudState(message: message));
  }
}
