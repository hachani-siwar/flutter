// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/presentation/blocs/classe_crud/classe_crud_bloc.dart';
import 'package:proj/features/classes/presentation/pages/classes_page.dart';
import 'package:proj/features/classes/presentation/widgets/add_update_classes_page/form_widget.dart';
import 'package:proj/global/util/snackbar_message.dart';
import 'package:proj/global/widgets/loading_widget.dart';

class AddUpdateClassePage extends StatelessWidget {
  final Classe? classe;
  final bool isUpdateClasse;
  const AddUpdateClassePage({
    Key? key,
    this.classe,
    required this.isUpdateClasse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(), body: _buildBody());
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdateClasse ? "Edit Class" : "Add Class"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: BlocConsumer<ClasseCrudBloc, ClasseCrudState>(
            listener: (context, state) {
              if (state is MessageClasseCrudState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => ClassesPage()),
                    (route) => false);
              } else if (state is ErrorClasseCrudState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingClasseCrudState) {
                return LoadingWidget();
              }

              return FormWidget(
                  isUpdatePost: isUpdateClasse,
                  classe: isUpdateClasse ? classe : null);
            },
          )),
    );
  }
}
