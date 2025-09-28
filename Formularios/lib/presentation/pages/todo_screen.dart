import 'package:flutter/material.dart';
import 'package:flutter_forms/data/models/todo.dart';
import 'package:flutter_forms/presentation/widgets/todo_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _HomeState();
}

class _HomeState extends State<TodoScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  TodoPriority _priorityValue = TodoPriority.low;
  String _titleValue = '';
  String _descriptionValue = '';
  List<Todo> todos = [
    const Todo(
      title: 'Comprar leche',
      description: '¡No queda leche en la nevera!',
      priority: TodoPriority.high,
    ),
    const Todo(
      title: 'Hacer la cama',
      description: 'Mantén todo ordenado, por favor.',
      priority: TodoPriority.low,
    ),
    const Todo(
      title: 'Pagar las facturas',
      description: 'Hay que pagar las facturas.',
      priority: TodoPriority.urgent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tareas'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),
            Form(
              key: _formGlobalKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Título")),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Debes especificar un título";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _titleValue = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Descripción"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Debes especificar una descripción";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _descriptionValue = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(label: Text("Prioridad")),
                    initialValue: _priorityValue,
                    items: TodoPriority.values.map((prioritySel) {
                      return DropdownMenuItem(
                        value: prioritySel,
                        child: Text(prioritySel.label),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return "Debes especificar una prioridad";
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      setState(() {
                        _priorityValue = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()) {
                        _formGlobalKey.currentState?.save();
                        setState(() {
                          todos.add(
                            Todo(
                              title: _titleValue,
                              description: _descriptionValue,
                              priority: _priorityValue,
                            ),
                          );
                        });
                        _formGlobalKey.currentState!.reset();
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text("Añadir"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
