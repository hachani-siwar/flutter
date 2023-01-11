// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/presentation/pages/msg_detail_page.dart';

class MsgListWidget extends StatelessWidget {
  final List<Msg> msgs;

  const MsgListWidget({
    Key? key,
    required this.msgs,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: msgs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(msgs[index].id.toString()),
          title: Text(
            msgs[index].title?? "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(msgs[index].content ?? ''),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MsgDetailPages(msg: msgs[index]),
              ),
            );
          }),
        );
      },
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
      ),
    );
  }
}
