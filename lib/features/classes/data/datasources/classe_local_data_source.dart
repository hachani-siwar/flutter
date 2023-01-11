import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:proj/features/classes/data/models/classe_model.dart';
import 'package:proj/global/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ClasseLocalDataSource {
  Future<List<ClasseModel>> getCachedClasses();
  Future<Unit> cacheClasses(List<ClasseModel> classeModels);
}

const CACHED_CLASSES = "CACHED_CLASSES";

class ClasseLocalDataSourceImpl implements ClasseLocalDataSource {
  final SharedPreferences sharedPreferences;

  ClasseLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheClasses(List<ClasseModel> classeModels) {
    List classeModelsToJson = classeModels
        .map<Map<String, dynamic>>((classeModel) => classeModel.toJson())
        .toList();
    sharedPreferences.setString(
        CACHED_CLASSES, json.encode(classeModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<ClasseModel>> getCachedClasses() {
    final jsonString = sharedPreferences.getString(CACHED_CLASSES);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<ClasseModel> jsonToClasseModel = decodeJsonData
          .map<ClasseModel>(
              (jsonClasseModel) => ClasseModel.fromJson(jsonClasseModel))
          .toList();
      return Future.value(jsonToClasseModel);
    } else {
      throw EmpetyCacheException();
    }
  }
}
