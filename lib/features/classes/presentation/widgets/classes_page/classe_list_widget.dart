// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/presentation/pages/classe_detail_page.dart';

class ClasseListWidget extends StatelessWidget {
  final List<Classe> classes;

  const ClasseListWidget({
    Key? key,
    required this.classes,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: classes.length,
      itemBuilder: (context, index) {
        return ListTile(
        //  leading: Text(classes[index].id.toString()),
          title: Text(
            classes[index].name ?? "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(classes[index].grade ?? ''),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ClasseDetailPages(classe: classes[index]),
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
