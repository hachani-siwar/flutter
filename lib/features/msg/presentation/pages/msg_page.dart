import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/msg/presentation/blocs/msg/msg_bloc.dart';
import 'package:proj/features/msg/presentation/pages/add_update_msg_page.dart';
import 'package:proj/features/msg/presentation/widgets/msg_page/msg_list_widget.dart';
import 'package:proj/features/msg/presentation/widgets/msg_page/message_display_widget.dart';
import 'package:proj/global/widgets/loading_widget.dart';

class MsgPages extends StatelessWidget {
  const MsgPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _BuildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text('Msgs'),
      );
  Widget _BuildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<MsgsBloc, MsgsState>(builder: (context, state) {
        if (state is LoadingMsgsState) {
          return const LoadingWidget();
        } else if (state is LoadedMsgsState) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: MsgListWidget(msgs: state.msgs),
          );
        } else if (state is ErrorMsgsState) {
          return MessageDisplayWidget(message: state.message);
        } else {
          return LoadingWidget();
        }
      }),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<MsgsBloc>(context).add(RefreshMsgsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddUpdateMsgPage(
                      isUpdateMsg: false,
                    )));
      },
      child: Icon(Icons.add),
    );
  }
}
