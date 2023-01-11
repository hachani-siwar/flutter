import 'package:flutter/material.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/presentation/pages/add_update_msg_page.dart';

class UpdateMsgBtnWidget extends StatelessWidget {
  final Msg msg;
  const UpdateMsgBtnWidget({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddUpdateMsgPage(
                msg: msg,
                isUpdateMsg: true,
              ),
            ));
      },
      icon: Icon(Icons.edit),
      label: Text("Edit"),
    );
  }
}
