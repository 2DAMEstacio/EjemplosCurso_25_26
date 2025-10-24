import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nuevo TODO'),
      content: TextField(
        controller: _ctrl,
        decoration: const InputDecoration(hintText: 'Título'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _ctrl.text),
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
