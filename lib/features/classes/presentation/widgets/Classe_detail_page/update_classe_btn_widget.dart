import 'package:flutter/material.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/presentation/pages/add_update_classes_page.dart';

class UpdateClasseBtnWidget extends StatelessWidget {
  final Classe classe;
  const UpdateClasseBtnWidget({
    Key? key,
    required this.classe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddUpdateClassePage(
                classe: classe,
                isUpdateClasse: true,
              ),
            ));
      },
      icon: Icon(Icons.edit),
      label: Text("Edit"),
    );
  }
}
