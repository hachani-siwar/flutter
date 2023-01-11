part of 'classes_bloc.dart';

abstract class ClassesState extends Equatable {
  const ClassesState();

  @override
  List<Object> get props => [];
}

class ClassesInitial extends ClassesState {}

class LoadingClassesState extends ClassesState {}

class LoadedClassesState extends ClassesState {
  final List<Classe> classes;

  LoadedClassesState({required this.classes});
  @override
  List<Object> get props => [classes];
}

class ErrorClassesState extends ClassesState {
  final String message;

  ErrorClassesState({required this.message});
  List<Object> get props => [message];
}
