# 📋 Flutter Forms -- Lista de Tareas

Este proyecto es una aplicación sencilla en **Flutter** cuyo objetivo es
mostrar cómo trabajar con **formularios**, capturar datos del usuario y
gestionar una **lista de tareas (ToDo list)** con distintos niveles de
prioridad.

---

## 🚀 Características principales

- **Formulario con validación**: se valida que el usuario introduzca
  título, descripción y prioridad antes de añadir una tarea.\
- **Gestión de estado** con `setState`: cada vez que se añade una
  tarea, la lista se actualiza en pantalla.\
- **Enum de prioridades**: las tareas tienen un nivel de prioridad
  (`Urgente`, `Alta`, `Media`, `Baja`), cada uno asociado a un color.\
- **DropdownButtonFormField**: selector desplegable para elegir la
  prioridad de una nueva tarea.\
- **Reset de campos**: posibilidad de limpiar los inputs y dejar el
  formulario listo para una nueva entrada.\
- **Lista dinámica**: las tareas añadidas se muestran en una lista que
  crece según la interacción del usuario.

---

## 🛠️ Estructura del proyecto

- **`models/todo.dart`**\
  Define la clase `Todo` y el `enum TodoPriority`.

  - `Todo` contiene título, descripción y prioridad.\
  - `TodoPriority` define los tipos de prioridad con su texto y
    color asociado.

- **`presentation/widgets/todo_list.dart`**\
  Widget que muestra la lista de tareas en pantalla.

- **`presentation/screens/todo_screen.dart`**\
  Pantalla principal de la app:

  - Contiene el formulario (`Form`) con `TextFormField` para título
    y descripción, y un `DropdownButtonFormField` para la
    prioridad.\
  - Muestra la lista de tareas actuales.\
  - Lógica para añadir nuevas tareas con validación y guardado.

---

## 🧑‍💻 Flujo de uso

1.  El usuario abre la pantalla principal.\
2.  Ve una lista de tareas iniciales (ejemplo: "Comprar leche", "Pagar
    facturas"...).\
3.  Puede rellenar el formulario escribiendo un **título**, una
    **descripción** y eligiendo una **prioridad** en el desplegable.\
4.  Al pulsar en **Añadir**:
    - Se validan los campos.\
    - Si todo es correcto, se guarda la tarea en la lista.\
    - La lista se actualiza automáticamente en pantalla.\
5.  Opcionalmente, el usuario puede resetear el formulario para empezar
    de nuevo.

---

## 📚 Conceptos clave que se practican

- **Uso del widget Form** para agrupar campos de entrada.\
- **Validación de campos** con `validator`.\
- **Guardado de datos** con `onSaved` y variables de estado.\
- **Reset de formulario** con `reset()`.\
- **Dropdown con opciones dinámicas** generadas a partir de un
  `enum`.\
- **Gestión de estado local** con `setState` para redibujar la UI
  cuando cambia la lista.

---

## ▶️ Cómo ejecutar el proyecto

1.  Clona este repositorio.\
2.  Asegúrate de tener Flutter instalado y configurado.\
3.  Ejecuta en terminal:

```bash
flutter pub get
flutter run
```

---

## 📝 Próximos pasos / posibles mejoras

- Persistir las tareas en base de datos o almacenamiento local
  (`shared_preferences`, `sqflite`).\
- Añadir edición y eliminación de tareas.\
- Integrar un gestor de estado más robusto (`Provider`, `Riverpod`,
  `Bloc`) en lugar de `setState`.\
- Crear tests de validación del formulario.
