import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/domain/usecases/add_classe.dart';
import 'package:proj/features/classes/domain/usecases/delete_classe.dart';
import 'package:proj/features/classes/domain/usecases/update_classe.dart';
import 'package:proj/global/error/failures.dart';
import 'package:proj/global/strings/fails.dart';
import 'package:proj/global/strings/messages.dart';

part 'classe_crud_event.dart';
part 'classe_crud_state.dart';

class ClasseCrudBloc extends Bloc<ClasseCrudEvent, ClasseCrudState> {
  ClasseCrudBloc(
      {required this.addClasse,
      required this.deleteClasse,
      required this.updateClasse})
      : super(ClasseCrudInitial()) {
    on<ClasseCrudEvent>((event, emit) async {
      if (event is AddClasseEvent) {
        emit(LoadingClasseCrudState());
        final failOrDoneMessage = await addClasse(event.classe);
        emit(_eitherDoneOrErrorMessage(failOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateClasseEvent) {
        emit(LoadingClasseCrudState());
        final failOrDoneMessage = await updateClasse(event.classe);
        emit(_eitherDoneOrErrorMessage(
            failOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeleteClasseEvent) {
        emit(LoadingClasseCrudState());
        final failOrDoneMessage = await deleteClasse(event.classeId);
        emit(_eitherDoneOrErrorMessage(
            failOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  final AddClasseUsecase addClasse;
  final DeleteClasseUsecase deleteClasse;
  final UpdateClasseUsecase updateClasse;

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

  ClasseCrudState _eitherDoneOrErrorMessage(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        (failure) =>
            ErrorClasseCrudState(message: _mapFailureToMessage(failure)),
        (_) => MessageClasseCrudState(message: message));
  }
}
