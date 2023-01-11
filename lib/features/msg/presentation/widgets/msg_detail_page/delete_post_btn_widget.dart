import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/msg/presentation/blocs/msg_crud/msg_crud_bloc.dart';
import 'package:proj/features/msg/presentation/pages/msg_page.dart';
import 'package:proj/global/util/snackbar_message.dart';
import 'package:proj/global/widgets/loading_widget.dart';
import 'delete_dialog_widget.dart';

class DeleteMsgBtnWidget extends StatelessWidget {
  final String msgId;
  const DeleteMsgBtnWidget({
    Key? key,
    required this.msgId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, msgId),
      icon: Icon(Icons.delete_outline),
      label: Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, String postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<MsgCrudBloc, MsgCrudState>(
            listener: (context, state) {
              if (state is MessageMsgCrudState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => MsgPages(),
                    ),
                    (route) => false);
              } else if (state is ErrorMsgCrudState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingMsgCrudState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(msgId: msgId);
            },
          );
        });
  }
}
