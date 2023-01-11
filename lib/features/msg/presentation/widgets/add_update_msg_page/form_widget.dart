import 'dart:math';

import 'package:proj/features/msg/domain/entities/msg.dart';
import 'package:proj/features/msg/presentation/blocs/msg_crud/msg_crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Msg? msg;
  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.msg,
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
      _titleController.text = widget.msg!.title ?? "";
      _bodyController.text = widget.msg!.content ?? "";
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
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiLines: true, controller: _bodyController),
            FormSubmitBtn(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final msg = Msg(
        id: widget.isUpdatePost ? widget.msg!.id : toString(),
        title: _titleController.text,
        content: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<MsgCrudBloc>(context)
            .add(UpdateMsgEvent(msg: msg));
      } else {
        BlocProvider.of<MsgCrudBloc>(context)
            .add(AddMsgEvent(msg: msg));
      }
    }
  }
}
