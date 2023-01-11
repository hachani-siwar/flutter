import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:proj/features/msg/data/models/msg_model.dart';
import 'package:http/http.dart' as http;
import 'package:proj/global/error/exceptions.dart';
import 'package:proj/global/network/URL.dart';

abstract class MsgRemoteDataSource {
  Future<List<MsgModel>> getAllMsgs();
  Future<Unit> deleteMsg(String id);
  Future<Unit> updateMsg(MsgModel msgModel);
  Future<Unit> addMsg(MsgModel msgModel);
}

class MsgRemoteDataSourceImpl implements MsgRemoteDataSource {
  final http.Client client;

  MsgRemoteDataSourceImpl({required this.client});
  @override
  Future<List<MsgModel>> getAllMsgs() async {
    final response = await client.get(Uri.parse("${BASE_URL}messages"),
        headers: {"content-type": "application.json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<MsgModel> msgModels = decodedJson
          .map<MsgModel>(
              (jsonMsgModel) => MsgModel.fromJson(jsonMsgModel))
          .toList();
      return msgModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addMsg(MsgModel msgModel) async {
    final body = {"title": msgModel.title, "content": msgModel.content};
    final response =
        await client.post(Uri.parse("${BASE_URL}messages"), body: body);
    if (response.statusCode == 201|| response.statusCode==200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteMsg(String msgId) async {
    final response = await client.delete(
      Uri.parse("${BASE_URL}messages/$msgId"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateMsg(MsgModel msgModel) async {
    final id = msgModel.id;
    final body = {
      "id": msgModel.id,
      "title": msgModel.title,
      "content": msgModel.content,
    };
    final responce =
        await client.put(Uri.parse("${BASE_URL}messages/$id"), body: body);
    if (responce.statusCode == 200 || responce.statusCode == 204) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
