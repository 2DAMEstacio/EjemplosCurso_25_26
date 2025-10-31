import 'package:flutter/material.dart';

class TodoNoDataItem extends StatelessWidget {
  const TodoNoDataItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_outlined, size: 48),
          const SizedBox(height: 8),
          Text(
            'Sin tareas. ¡Crea la primera!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
