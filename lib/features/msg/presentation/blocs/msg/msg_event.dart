part of 'msg_bloc.dart';

abstract class MsgsEvent extends Equatable {
  const MsgsEvent();

  @override
  List<Object> get props => [];
}

class GetAllMsgsEvent extends MsgsEvent {}

class RefreshMsgsEvent extends MsgsEvent {}
