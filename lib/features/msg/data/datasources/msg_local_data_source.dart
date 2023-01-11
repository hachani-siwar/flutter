import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:proj/features/msg/data/models/msg_model.dart';
import 'package:proj/global/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MsgLocalDataSource {
  Future<List<MsgModel>> getCachedMsgs();
  Future<Unit> cachedMsgs(List<MsgModel> msgModels);
}

const CACHED_MSGS = "CACHED_MSGS";

class MsgLocalDataSourceImpl implements MsgLocalDataSource {
  final SharedPreferences sharedPreferences;

  MsgLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachedMsgs(List<MsgModel> msgModels) {
    List msgModelsToJson = msgModels
        .map<Map<String, dynamic>>((msgModel) => msgModel.toJson())
        .toList();
    sharedPreferences.setString(
        CACHED_MSGS, json.encode(msgModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<MsgModel>> getCachedMsgs() {
    final jsonString = sharedPreferences.getString(CACHED_MSGS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<MsgModel> jsonToMsgModel = decodeJsonData
          .map<MsgModel>(
              (jsonMsgModel) => MsgModel.fromJson(jsonMsgModel))
          .toList();
      return Future.value(jsonToMsgModel);
    } else {
      throw EmpetyCacheException();
    }
  }
}
