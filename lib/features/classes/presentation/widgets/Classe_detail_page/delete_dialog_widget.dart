import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/classes/presentation/blocs/classe_crud/classe_crud_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final String classeId;
  const DeleteDialogWidget({
    Key? key,
    required this.classeId,
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
            BlocProvider.of<ClasseCrudBloc>(context).add(
              DeleteClasseEvent(classeId: classeId),
            );
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
