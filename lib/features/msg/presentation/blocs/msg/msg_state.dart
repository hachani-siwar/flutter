part of 'msg_bloc.dart';

abstract class MsgsState extends Equatable {
  const MsgsState();

  @override
  List<Object> get props => [];
}

class MsgsInitial extends MsgsState {}

class LoadingMsgsState extends MsgsState {}

class LoadedMsgsState extends MsgsState {
  final List<Msg> msgs;

  LoadedMsgsState({required this.msgs});
  @override
  List<Object> get props => [msgs];
}

class ErrorMsgsState extends MsgsState {
  final String message;

  ErrorMsgsState({required this.message});
  List<Object> get props => [message];
}
