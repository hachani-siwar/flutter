import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/classes/presentation/blocs/classes/classes_bloc.dart';
import 'package:proj/features/classes/presentation/pages/add_update_classes_page.dart';
import 'package:proj/features/classes/presentation/widgets/classes_page/classe_list_widget.dart';
import 'package:proj/features/classes/presentation/widgets/classes_page/message_display_widget.dart';
import 'package:proj/global/widgets/loading_widget.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _BuildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text('Classes'),
      );
  Widget _BuildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<ClassesBloc, ClassesState>(builder: (context, state) {
        if (state is LoadingClassesState) {
          return const LoadingWidget();
        } else if (state is LoadedClassesState) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ClasseListWidget(classes: state.classes),
          );
        } else if (state is ErrorClassesState) {
          return MessageDisplayWidget(message: state.message);
        } else {
          return LoadingWidget();
        }
      }),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<ClassesBloc>(context).add(RefreshClassesEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AddUpdateClassePage(
                      isUpdateClasse: false,
                    )));
      },
      child: Icon(Icons.add),
    );
  }
}
