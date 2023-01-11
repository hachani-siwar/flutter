part of 'classe_crud_bloc.dart';

abstract class ClasseCrudEvent extends Equatable {
  const ClasseCrudEvent();

  @override
  List<Object> get props => [];
}

class AddClasseEvent extends ClasseCrudEvent {
  final Classe classe;

  AddClasseEvent({required this.classe});
  @override
  List<Object> get props => [classe];
}

class UpdateClasseEvent extends ClasseCrudEvent {
  final Classe classe;

  UpdateClasseEvent({required this.classe});
  @override
  List<Object> get props => [classe];
}

class DeleteClasseEvent extends ClasseCrudEvent {
  final String classeId;

  DeleteClasseEvent({required this.classeId});
  @override
  List<Object> get props => [classeId];
}
