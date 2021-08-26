import 'package:flutter/material.dart';
import 'package:mobile/features/home/home.dart';

class TaskFormDialogWidget extends StatefulWidget {
  final TaskModel model;

  const TaskFormDialogWidget({this.model});

  @override
  _TaskFormDialogWidgetState createState() => _TaskFormDialogWidgetState();
}

class _TaskFormDialogWidgetState extends State<TaskFormDialogWidget> {
  GlobalKey<FormState> _formKey;
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    _formKey = GlobalKey();

    _titleController = TextEditingController(
      text: widget.model?.title ?? '',
    );

    _descriptionController = TextEditingController(
      text: widget.model?.description ?? '',
    );

    super.initState();
  }

  void onSavePressed() {
    if (_formKey.currentState.validate()) {
      Navigator.pop(
          context,
          TaskModel(
              id: widget.model?.id,
              title: _titleController.text,
              isDone: widget.model?.isDone ?? false,
              description: _descriptionController.text,
              createdAt: widget.model?.createdAt ?? DateTime.now()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${widget.model != null ? 'Editar' : 'Criar'} Tarefa',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0)),
            _buildTextFields(context),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: onSavePressed,
                  child: Text(
                    widget.model != null ? 'Salvar' : 'Criar',
                  )),
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(hintText: 'Título'),
          validator: (text) {
            if (text.isEmpty) {
              return 'Campo obrigatório!';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(hintText: 'Descrição'),
          validator: (text) {
            if (text.isEmpty) {
              return 'Campo obrigatório!';
            }
            return null;
          },
        ),
      ],
    );
  }
}
