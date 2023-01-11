import 'package:flutter/material.dart';
import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/presentation/widgets/msg_detail_page/msg_detail_page.dart';

class MsgDetailPages extends StatelessWidget {
  final Msg msg;
  const MsgDetailPages({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text("Msgs Detail"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MsgDetailWidget(
          msg: msg,
        ),
      ),
    );
  }
}
