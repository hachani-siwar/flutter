import 'package:proj/features/msg/domain/entities/msg.dart';

import 'update_msg_btn_widget.dart';
import 'package:flutter/material.dart';

import 'delete_post_btn_widget.dart';

class MsgDetailWidget extends StatelessWidget {
  final Msg msg;
  const MsgDetailWidget({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            msg.title ?? "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 50,
          ),
          Text(
            msg.content ?? "",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdateMsgBtnWidget(msg: msg),
              DeleteMsgBtnWidget(msgId: msg.id??"")
            ],
          )
        ],
      ),
    );
  }
}
