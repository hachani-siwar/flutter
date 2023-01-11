import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/classes/presentation/blocs/classe_crud/classe_crud_bloc.dart';
import 'package:proj/features/classes/presentation/pages/classes_page.dart';
import 'package:proj/global/util/snackbar_message.dart';
import 'package:proj/global/widgets/loading_widget.dart';
import 'delete_dialog_widget.dart';

class DeleteClasseBtnWidget extends StatelessWidget {
  final String classeId;
  const DeleteClasseBtnWidget({
    Key? key,
    required this.classeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, classeId),
      icon: Icon(Icons.delete_outline),
      label: Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, String postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<ClasseCrudBloc, ClasseCrudState>(
            listener: (context, state) {
              if (state is MessageClasseCrudState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => ClassesPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorClasseCrudState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingClasseCrudState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(classeId: classeId);
            },
          );
        });
  }
}
