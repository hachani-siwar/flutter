import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/msg/presentation/blocs/msg_crud/msg_crud_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String msgId;
  const DeleteDialogWidget({
    Key? key,
    required this.msgId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<MsgCrudBloc>(context).add(
              DeleteMsgEvent(msgId: msgId),
            );
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
