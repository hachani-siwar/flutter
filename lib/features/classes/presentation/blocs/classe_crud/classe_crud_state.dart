part of 'classe_crud_bloc.dart';

abstract class ClasseCrudState extends Equatable {
  const ClasseCrudState();

  @override
  List<Object> get props => [];
}

class ClasseCrudInitial extends ClasseCrudState {}

class LoadingClasseCrudState extends ClasseCrudState {}

class ErrorClasseCrudState extends ClasseCrudState {
  final String message;

  ErrorClasseCrudState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageClasseCrudState extends ClasseCrudState {
  final String message;

  MessageClasseCrudState({required this.message});
}
