import 'dart:math';

import 'package:proj/features/classes/domain/entities/classe.dart';
import 'package:proj/features/classes/presentation/blocs/classe_crud/classe_crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Classe? classe;
  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.classe,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.classe!.name ?? "";
      _bodyController.text = widget.classe!.grade ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Classe", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Grade", multiLines: true, controller: _bodyController),
            FormSubmitBtn(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final classe = Classe(
        id: widget.isUpdatePost ? widget.classe!.id : toString(),
        name: _titleController.text,
        grade: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<ClasseCrudBloc>(context)
            .add(UpdateClasseEvent(classe: classe));
      } else {
        BlocProvider.of<ClasseCrudBloc>(context)
            .add(AddClasseEvent(classe: classe));
      }
    }
  }
}
