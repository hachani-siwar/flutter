import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:proj/features/classes/data/models/classe_model.dart';
import 'package:http/http.dart' as http;
import 'package:proj/global/error/exceptions.dart';
import 'package:proj/global/network/URL.dart';

abstract class ClasseRemoteDataSource {
  Future<List<ClasseModel>> getAllClasses();
  Future<Unit> deleteClasse(String id);
  Future<Unit> updateClasse(ClasseModel classeModel);
  Future<Unit> addClasse(ClasseModel classeModel);
}

class ClasseRemoteDataSourceImpl implements ClasseRemoteDataSource {
  final http.Client client;

  ClasseRemoteDataSourceImpl({required this.client});
  @override
  Future<List<ClasseModel>> getAllClasses() async {
    final response = await client.get(Uri.parse("${BASE_URL}classes"),
        headers: {"content-type": "application.json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<ClasseModel> classeModels = decodedJson
          .map<ClasseModel>(
              (jsonClasseModel) => ClasseModel.fromJson(jsonClasseModel))
          .toList();
      return classeModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addClasse(ClasseModel classeModel) async {
    final body = {"name": classeModel.name, "classeGrade": classeModel.grade};
    final response =
        await client.post(Uri.parse("${BASE_URL}classes"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteClasse(String classeId) async {
    final response = await client.delete(
      Uri.parse("${BASE_URL}classes/$classeId"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateClasse(ClasseModel classeModel) async {
    final body = {
      "id": classeModel.id,
      "name": classeModel.name,
      "classeGrade": classeModel.grade,
    };
    final responce =
        await client.put(Uri.parse("${BASE_URL}classes"), body: body);
    if (responce.statusCode == 200 || responce.statusCode == 204) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
