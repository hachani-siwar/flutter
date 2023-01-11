part of 'msg_crud_bloc.dart';

abstract class MsgCrudEvent extends Equatable {
  const MsgCrudEvent();

  @override
  List<Object> get props => [];
}

class AddMsgEvent extends MsgCrudEvent {
  final Msg msg;

  AddMsgEvent({required this.msg});
  @override
  List<Object> get props => [msg];
}

class UpdateMsgEvent extends MsgCrudEvent {
  final Msg msg;

  UpdateMsgEvent({required this.msg});
  @override
  List<Object> get props => [msg];
}

class DeleteMsgEvent extends MsgCrudEvent {
  final String msgId;

  DeleteMsgEvent({required this.msgId});
  @override
  List<Object> get props => [msgId];
}
