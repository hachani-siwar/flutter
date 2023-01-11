import 'package:flutter/material.dart';
import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/presentation/widgets/Classe_detail_page/classe_detail_widget.dart';

class ClasseDetailPages extends StatelessWidget {
  final Classe classe;
  const ClasseDetailPages({
    Key? key,
    required this.classe,
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
      title: Text("Classes Detail"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClasseDetailWidget(
          classe: classe,
        ),
      ),
    );
  }
}
