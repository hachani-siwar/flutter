import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/domain/usecases/get_all_classes.dart';
import 'package:proj/global/error/failures.dart';
import 'package:proj/global/strings/fails.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  final GetAllClassesUsecase getAllClasses;
  ClassesBloc({
    required this.getAllClasses,
  }) : super(ClassesInitial()) {
    on<ClassesEvent>((event, emit) async {
      if (event is GetAllClassesEvent) {
        emit(LoadingClassesState());

        final failureOrClasses = await getAllClasses();

        emit(_mapFailureOrClasseState(failureOrClasses));
      } else if (event is RefreshClassesEvent) {
        emit(LoadingClassesState());

        final failureOrClasses = await getAllClasses();

        emit(_mapFailureOrClasseState(failureOrClasses));
      }
    });
  }

  ClassesState _mapFailureOrClasseState(Either<Failure, List<Classe>> either) {
    return either.fold(
      (failure) => ErrorClassesState(
        message: _mapFailureToMessage(failure),
      ),
      (classes) => LoadedClassesState(
        classes: classes,
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
