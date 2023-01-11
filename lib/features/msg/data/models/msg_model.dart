import 'dart:convert';

import 'package:proj/features/msg/domain/entities/msg.dart';

class MsgModel extends Msg {
  MsgModel(
      {String? id, required String? title, required String? content, String? user})
      : super(id: id, title: title, content: content, user:user);

  factory MsgModel.fromJson(Map<String, dynamic> json) {
    return MsgModel(
        id: json['id'], title: json['title'], content: json['content'], user: json['user']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'content': content, 'user': user};
  }
}
