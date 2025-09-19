# 📘 README — Listado de Personas (Flutter)

Ejemplo didáctico para repasar:

- **Tipos de constructores** en Dart/Flutter (principal, **con nombre**, **factory**).
- **Navegación** con `Navigator.push`.
- Listado con **`ListView.builder`**.

---

## 🗂 Estructura real (según el ZIP)

```
lib/
  main.dart
  data/
    fake_data/
      personas_list.dart
    models/
      persona.dart
  domain/
  presentation/
    pages/
      persona_detail.dart
    widgets/
      persona_card.dart
  utils/
    functions.dart
```

### Qué contiene cada parte

- **`main.dart`**  
  Punto de entrada. Muestra un `ListView.builder` con los datos de `data/fake_data/personas_list.dart`.  
  Para **demostrar constructores**, elige aleatoriamente una variante de `PersonaCard`:

  ```dart
  final valor = Random().nextInt(4) + 1; // 1..4
  switch (valor) {
    case 1: return PersonaCard(...);
    case 2: return PersonaCard.compact(...);
    case 3: return PersonaCard.vip(...);
    default: return PersonaCard.fromJson(p);
  }
  ```

- **`data/fake_data/personas_list.dart`**  
  Lista `const List<Map<String,dynamic>>` con claves: `id, name, role, photo, nick, vip`.

- **`data/models/persona.dart`**  
  Modelo **Persona** con:
  - **Constructor principal** (named + `required` + opcionales con `default`).
  - **Constructor con nombre**: `Persona.anonymous()`.
  - **Constructor `factory`**: `Persona.fromJson(Map)` (normaliza/valida).
- **`presentation/widgets/persona_card.dart`**  
  Card sencilla (`Card + ListTile`) con **tres tipos de constructores** y un **factory**:

  - `PersonaCard(...)` (principal, `isVip=false` por defecto)
  - `PersonaCard.compact(...)` (variante compacta)
  - `PersonaCard.vip(...)` (muestra ⭐)
  - `PersonaCard.fromJson(Map)` (crea desde JSON usando `Persona.fromJson`)  
    Al tocar la card navega al detalle:

  ```dart
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => PersonaDetailPage(persona: persona)),
  );
  ```

- **`presentation/pages/persona_detail.dart`**  
  Página de detalle. Muestra foto o **iniciales**, nombre, rol, `@nick` y ⭐ si es VIP.

- **`utils/functions.dart`**  
  Helper `Functions.initials(String)` para generar iniciales si no hay foto.

- **`domain/`**  
  (Preparada para ampliaciones de dominio/use cases si quieres evolucionar a arquitectura limpia.)

---

## 🧭 Flujo de la app

1. `main.dart` levanta `MaterialApp` y pinta un **`ListView.builder`** con personas.
2. Cada ítem es una `PersonaCard` (en una de sus variantes) → **demuestra constructores**.
3. `onTap` en la card → `Navigator.push` a `PersonaDetailPage(persona: ...)`.

---

## 🚀 Ejecutar

```bash
flutter pub get
flutter run
```

---

## ✅ Objetivos didácticos cubiertos

- **Constructores**: principal, **con nombre** (`.compact`, `.vip`), **factory** (`fromJson`) tanto en el **widget** como en el **modelo**.
- **Navegación**: imperativa con `MaterialPageRoute`.
- **Listado**: `ListView.builder` consumiendo datos mock del módulo `data/`.
