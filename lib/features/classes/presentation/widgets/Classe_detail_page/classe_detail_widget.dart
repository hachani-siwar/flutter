import 'package:proj/features/classes/domain/entities/classe.dart';

import 'update_classe_btn_widget.dart';
import 'package:flutter/material.dart';

import 'delete_post_btn_widget.dart';

class ClasseDetailWidget extends StatelessWidget {
  final Classe classe;
  const ClasseDetailWidget({
    Key? key,
    required this.classe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            classe.name ?? "",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 50,
          ),
          Text(
            classe.grade ?? "",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdateClasseBtnWidget(classe: classe),
              DeleteClasseBtnWidget(classeId: classe.id)
            ],
          )
        ],
      ),
    );
  }
}
