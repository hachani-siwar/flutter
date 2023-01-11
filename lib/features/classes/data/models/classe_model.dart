import 'dart:convert';

import 'package:proj/features/classes/domain/entities/classe.dart';

class ClasseModel extends Classe {
  ClasseModel(
      {required String id, required String? name, required String? grade})
      : super(id: id, name: name, grade: grade);

  factory ClasseModel.fromJson(Map<String, dynamic> json) {
    return ClasseModel(
        id: json['id'], name: json['name'], grade: json['classeGrade']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'classeGrade': grade};
  }
}
