// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/presentation/blocs/msg_crud/msg_crud_bloc.dart';
import 'package:proj/features/msg/presentation/pages/msg_page.dart';
import 'package:proj/features/msg/presentation/widgets/add_update_msg_page/form_widget.dart';
import 'package:proj/global/util/snackbar_message.dart';
import 'package:proj/global/widgets/loading_widget.dart';

class AddUpdateMsgPage extends StatelessWidget {
  final Msg? msg;
  final bool isUpdateMsg;
  const AddUpdateMsgPage({
    Key? key,
    this.msg,
    required this.isUpdateMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: _buildBody());
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdateMsg ? "Edit Msg" : "Add Msg"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: BlocConsumer<MsgCrudBloc,  MsgCrudState>(
            listener: (context, state) {
              if (state is MessageMsgCrudState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => MsgPages()),
                    (route) => false);
              } else if (state is ErrorMsgCrudState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingMsgCrudState) {
                return LoadingWidget();
              }

              return FormWidget(
                  isUpdatePost: isUpdateMsg,
                  msg: isUpdateMsg ? msg : null);
            },
          )),
    );
  }
}
