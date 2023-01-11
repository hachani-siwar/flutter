import 'package:equatable/equatable.dart';

class Msg extends Equatable {
  final String? id;
  final String? title;
  final String? content;
  final String? user;

  Msg({this.id, required this.title, required this.content, this.user});

  @override
  List<Object?> get props => [id, title, content,user];
}
