part of 'msg_crud_bloc.dart';

abstract class MsgCrudState extends Equatable {
  const MsgCrudState();

  @override
  List<Object> get props => [];
}

class MsgCrudInitial extends MsgCrudState {}

class LoadingMsgCrudState extends MsgCrudState {}

class ErrorMsgCrudState extends MsgCrudState {
  final String message;

  ErrorMsgCrudState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageMsgCrudState extends MsgCrudState {
  final String message;

  MessageMsgCrudState({required this.message});
}
