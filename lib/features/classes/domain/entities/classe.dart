import 'package:equatable/equatable.dart';

class Classe extends Equatable {
  final String id;
  final String? name;
  final String? grade;

  Classe({required this.id, required this.name, required this.grade});

  @override
  List<Object?> get props => [id, name, grade];
}
