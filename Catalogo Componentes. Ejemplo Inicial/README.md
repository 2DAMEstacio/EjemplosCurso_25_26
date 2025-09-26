# Catálogo de Componentes – Ejemplo Inicial

Este proyecto es un ejemplo base en Flutter que ilustra cómo organizar un catálogo de componentes reutilizables siguiendo una arquitectura limpia y con un sistema de **gestión de temas (light/dark)** bien definido.

## 🚀 Estructura del proyecto

```
lib/
├── main.dart
├── app/
│   └── theme/
│       ├── app_palette.dart
│       └── app_theme.dart
├── core/
│   └── widgets/
│       └── app_button.dart
└── catalog/
    ├── catalog_page.dart
    ├── demos/
    │   └── buttons_demo.dart
    └── widgets/
        └── showcase_scaffold.dart
```

### 1. `main.dart`

Punto de arranque de la aplicación. Configura el `MaterialApp` con:

- **Tema claro y oscuro** (`AppTheme.light` y `AppTheme.dark`).
- **themeMode** en `system`, para adaptarse automáticamente a la preferencia del dispositivo.
- **home** → `CatalogPage`, que abre directamente el catálogo.

### 2. Gestión del **Theme**

#### `app_palette.dart`

Define los **colores base** de la aplicación en dos instancias:

- `AppPalette.light` → paleta para modo claro.
- `AppPalette.dark` → paleta para modo oscuro.

Cada paleta centraliza los colores clave (primario, secundario, danger, etc.), evitando hardcodear valores dentro de los widgets.

#### `app_theme.dart`

Construye el **ThemeData** de Flutter a partir de la paleta:

- Usa `ColorScheme.fromSeed` como base.
- Inyecta la paleta de colores (`AppPalette`) en el tema.
- Define tipografía mediante `textTheme` con jerarquía clara (títulos, subtítulos, cuerpo, captions).
- Expone dos getters: `AppTheme.light` y `AppTheme.dark`.

De esta forma, **cambiar el aspecto global de la app** (colores, tipografía) se hace en un único punto.

### 3. `core/widgets/app_button.dart`

Widget de botón reutilizable:

- Variantes: `primary`, `secondary`, `danger`.
- Estados: normal, deshabilitado, loading.
- Se apoya en `AppPalette` para asignar colores automáticamente según el tema.

### 4. Catálogo (`catalog/`)

Es una pantalla especial de la app donde se muestran los componentes.

- **`catalog_page.dart`**  
  Lista de demos disponibles (ej: botones).
- **`widgets/showcase_scaffold.dart`**  
  Scaffold común para todas las demos, incluye toggle de tema claro/oscuro.
- **`demos/buttons_demo.dart`**  
  Muestra el `AppButton` en distintas variantes y estados. Sirve como referencia visual y funcional.

## 📖 Uso

1. Clonar el repositorio.
2. Instalar dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecutar la app:
   ```bash
   flutter run
   ```
4. Al iniciar, se abrirá directamente el **catálogo de componentes** en la ruta `/catalog`.

## 🎨 Filosofía

- **Centralización**: Colores y tipografía se definen en un solo lugar (tema).
- **Reutilización**: Los componentes (`AppButton`) viven en `core/widgets` y se usan en todo el proyecto.
- **Documentación viva**: El catálogo es un escaparate interactivo para probar componentes en distintos estados.
- **Consistencia**: Evita hardcodear estilos; siempre usar `Theme.of(context)` y `AppPalette`.

---

## ✅ Próximos pasos

- Añadir más demos al catálogo (`text_fields_demo`, `tabs_demo`, `dropdowns_demo`, etc.).
- Extender `AppPalette` con colores de feedback (success, warning, info).
- Incluir golden tests para validar consistencia visual en claro/oscuro.
