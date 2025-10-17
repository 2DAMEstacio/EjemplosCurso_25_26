# Todo List – Flutter + Riverpod (AsyncNotifier) + Clean Architecture (lite)

Este proyecto implementa una **app de lista de tareas** con **login por PIN**, usando **Flutter** y **Riverpod 2.x**. El objetivo es didáctico: mostrar una arquitectura limpia (ligera) separando **presentación / dominio / datos**, y aprovechar **AsyncNotifier + AsyncValue** para gestionar estado asíncrono.

---

## 🚀 Características

- **Login por PIN** (simulado) usando `Notifier<bool>`.
- **Listado de TODOs** con añadir, alternar completado y eliminar.
- **Gestión de estado moderna** con `AsyncNotifier<List<Todo>>` y `AsyncValue` para loading/error/data.
- **Datasource en memoria** (array) → ideal para docencia o prototipos.
- **Repositorio** que abstrae la fuente de datos.
- **SnackBars** reactivos ante login/logout con `ref.listen` (ver `core/utils.dart`).

---

## 🧱 Stack

- **Flutter** (Material 3)
- **Riverpod 2.x** (`flutter_riverpod`)
- **equatable** (comparación por valor en entidades)
- **uuid** (IDs de tareas)

> **Nota:** el ZIP no incluye `pubspec.yaml`. Asegúrate de declarar las dependencias en tu proyecto.

```yaml
# pubspec.yaml (fragmento sugerido)
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  equatable: ^2.0.5
  uuid: ^4.4.2

environment:
  sdk: ">=3.3.0 <4.0.0"
```

---

## 🗂️ Estructura de carpetas

```
lib/
  main.dart
  core/
    utils.dart                 # helpers (SnackBars de login/logout con ref.listen)
  domain/
    todo/
      entities/todo.dart       # Entidad de dominio (Equatable)
      repositories/todo_repository.dart
    auth/                      # (reservado para futuras extensiones)
  data/
    todo/
      datasources/
        todo_local_datasource.dart   # Array en memoria
      models/
        todo_model.dart        # Modelo de datos extiende entidad
      repositories/
        todo_repository_impl.dart
  presentation/
    auth/
      pages/login_page.dart
      providers/auth_providers.dart  # AuthNotifier + provider
      widgets/auth_gate.dart         # Decide entre LoginPage/TodosPage
    todo/
      pages/todo_page.dart
      providers/todo_providers.dart  # TodosNotifier (AsyncNotifier) + providers derivados
      widgets/todo_item.dart
      widgets/todo_no_data_item.dart
```

---

## 🧠 Riverpod: AsyncNotifier + AsyncValue

El `TodosNotifier` extiende `AsyncNotifier<List<Todo>>`. Riverpod llama a `build()` para cargar datos iniciales y el `state` es un `AsyncValue<List<Todo>>` que puede estar en:

- `AsyncLoading()` → cargando
- `AsyncData(value)` → datos disponibles
- `AsyncError(error, stackTrace)` → fallo en la carga/proceso

### Ejemplo (resumen)

```dart
class TodosNotifier extends AsyncNotifier<List<Todo>> {
  late final TodoUseCases todoUseCases;

  @override
  Future<List<Todo>> build() async {
    todoUseCases = TodoUseCases(TodoRepositoryImpl(TodoLocalDataSource()));
    return todoUseCases.getTodos();
  }

  Future<void> add(String title) async {
    if (title.trim().isEmpty) return;
    await todoUseCases.addTodo(title);
    state = await AsyncValue.guard(todoUseCases.getTodos);
  }

  Future<void> toggle(String id) async {
    await todoUseCases.toggleComplete(id);
    state = await AsyncValue.guard(todoUseCases.getTodos);
  }

  Future<void> remove(String id) async {
    await todoUseCases.deleteTodo(id);
    state = await AsyncValue.guard(todoUseCases.getTodos);
  }
}
```

### Uso en la UI con `when`

```dart
final state = ref.watch(todosProvider);

body: state.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (e, _) => Center(child: Text('Error: $e')),
  data: (todos) => todos.isEmpty
      ? const TodoNoDataItem()
      : ListView.separated(
          itemCount: todos.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (_, i) => TodoItem(todo: todos[i]),
        ),
);
```

### Derivados con `valueOrNull`

```dart
final totalTodosProvider = Provider<int>((ref) {
  final todos = ref.watch(todosProvider).valueOrNull ?? const <Todo>[];
  return todos.length;
});
```

---

## 🔐 Autenticación por PIN

- `AuthNotifier extends Notifier<bool>` expone si el usuario está autenticado.
- `loginWithPin(pin)` compara con una constante `kSecretPin = '4242'`.
- El widget `AuthGate` decide si mostrar `LoginPage` o `TodosPage`.

```dart
final isAuthenticatedProvider = NotifierProvider<AuthNotifier, bool>(() {
  return AuthNotifier();
});
```

En `LoginPage`, tras un login correcto se muestra un **SnackBar** reactivo gracias a `ref.listen` (ver `core/utils.dart`).

---

## 💾 Capa de datos (in-memory)

- `TodoLocalDataSource` mantiene un `List<TodoModel>` en memoria.
- `TodoRepositoryImpl` orquesta altas/bajas/cambios y devuelve entidades `Todo`.

> Esta elección es intencionalmente simple para la docencia. Cambiar a `SharedPreferences`, SQLite o API REST sería directo: solo habría que sustituir el datasource y mantener la interfaz del repositorio.

---

## ▶️ Cómo ejecutar

1. Crea un proyecto si aún no lo tienes:
   ```bash
   flutter create flutter_todo_list_riverpod
   ```
2. Copia el contenido de `lib/` del ZIP a tu proyecto.
3. Asegura las dependencias en `pubspec.yaml` (ver sección _Stack_).
4. Ejecuta:
   ```bash
   flutter pub get
   flutter run
   ```

> **PIN por defecto:** `4242`

---
