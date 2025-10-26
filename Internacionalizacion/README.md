# i18n Study Buddy — Ejemplo de internacionalización en Flutter

Pequeña app de ejemplo que muestra **internacionalización (i18n)** en Flutter con:

- **`flutter_localizations`** e **`intl`** (plural/select/formatos),
- **archivos ARB** para strings (ES/EN/IT),
- **Riverpod** para estado (**`flutter_riverpod`**),
- **SharedPreferences** para persistir la preferencia de idioma,
- y un **selector de idioma** dentro de la UI.

> El propósito es servir como _starter_ o material didáctico para entender cómo estructurar i18n en Flutter.

---

## Demo rápida

- Idiomas soportados: **es**, **en**, **it**.
- Muestra ejemplos de:
  - Saludo con placeholder (`hello(name)`),
  - Pluralización (`applesCount(count)`),
  - Select por género (`userGender(gender)`),
  - Placeholders de **fecha** y **moneda**.
- El idioma seleccionado se guarda en **SharedPreferences** y se aplica en todo el `MaterialApp`.

---

## Estructura de carpetas

```
lib/
├─ main.dart
├─ core/
│  ├─ l10n/
│  │  ├─ app_*.arb                    # Strings fuente (EN/ES/IT)
│  │  ├─ app_localizations.dart       # API de localizaciones (generada)
│  │  ├─ app_localizations_en.dart    # Implementación EN (generada)
│  │  ├─ app_localizations_es.dart    # Implementación ES (generada)
│  │  └─ app_localizations_it.dart    # Implementación IT (generada)
│  └─ utils/
│     └─ formatters.dart              # Formateadores de fecha/moneda (intl)
└─ features/
   └─ preferences/
      ├─ controllers/
      │  └─ preferences_controller.dart   # Riverpod AsyncNotifier (idioma)
      ├─ data/
      │  ├─ models/preferences.dart       # Modelo Preferences
      │  └─ repositories/preferences_repository.dart  # SharedPreferences
      └─ presentation/
         ├─ pages/selected_language_page.dart         # Pantalla principal
         └─ widgets/locale_selector_form.dart         # Selector de idioma
```

---

## Requisitos

- **Flutter** 3.x o superior
- **Dart** 3.x
- Plataformas soportadas: Android, iOS, web (según configuración de tu proyecto)
- Dependencias principales:
  - `flutter_localizations` (SDK)
  - `intl`
  - `flutter_riverpod`
  - `shared_preferences`

> Asegúrate de tener el SDK de Flutter instalado y en el `PATH` (`flutter doctor`).

---

## Cómo ejecutar

1. Instala dependencias:
   ```bash
   flutter pub get
   ```
2. Ejecuta la app:
   ```bash
   flutter run
   ```
3. Cambia el idioma desde el icono de **lenguaje** en el `AppBar`.

---

## ¿Dónde está el soporte i18n?

- **`lib/core/l10n/app_*.arb`**: archivos **ARB** con las cadenas fuente. Ejemplo (ES):

  ```json
  {
    "@@locale": "es",
    "hello": "¡Hola, {name}!",
    "@hello": {
      "description": "Saluda al usuario por su nombre.",
      "placeholders": { "name": { "type": "String" } }
    },
    "applesCount": "{count, plural, =0{Sin manzanas} one{Una manzana} other{{count} manzanas}}",
    "@applesCount": {
      "description": "Ejemplo de pluralización.",
      "placeholders": { "count": { "type": "int" } }
    }
  }
  ```

- **`lib/core/l10n/app_localizations*.dart`**: archivos **generados** por `gen-l10n` que exponen una API tipada:

  ```dart
  final l10n = AppLocalizations.of(context)!;
  l10n.hello("Flutter");
  l10n.applesCount(3);
  l10n.userGender("female"); // 'male' | 'female' | 'other'
  ```

- **`lib/core/utils/formatters.dart`**: formateadores con `intl` para **fecha** y **moneda**:
  ```dart
  String formatSampleDate(DateTime date) => DateFormat.yMMMd().format(date);
  String formatSampleCurrency(num amount) =>
      NumberFormat.simpleCurrency(name: 'EUR').format(amount);
  ```

---

## Configuración en `MaterialApp`

En `lib/main.dart` se declaran los `supportedLocales` y los `localizationsDelegates`, además de enlazar el `locale` a la preferencia guardada con Riverpod:

```dart
return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'i18n Study Buddy',
  theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF2255EE)),
  locale: selectedLocale, // desde Preferences (Riverpod + SharedPreferences)
  supportedLocales: const [Locale('en'), Locale('es'), Locale('it')],
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  home: const SelectedLanguagePage(),
);
```

---

## Estado y persistencia

- **Riverpod** (`AsyncNotifier`): `PreferencesNotifier` expone el estado `Preferences` con el `Locale` actual y permite `setLocale(Locale)`.
- **SharedPreferences**: `PreferencesRepository` lee/escribe `LANGUAGE` y `DARKMODE` (este último a modo de ejemplo).

```dart
await _repo.setLanguage(locale.languageCode);
final prefs = await _repo.getPreferences(); // devuelve Preferences(language: ...)
```

---

## Añadir un nuevo idioma

1. **Crea** un archivo ARB: `lib/core/l10n/app_fr.arb` (por ejemplo), siguiendo la misma estructura de claves.
2. **Declara** el nuevo locale en tu `MaterialApp` (`supportedLocales`) y en la configuración de `gen-l10n` si usas `l10n.yaml`.
3. **Genera** los archivos de localización:
   ```bash
   flutter gen-l10n
   ```
   Esto producirá `app_localizations_fr.dart` y actualizará la API.
4. **Usa** las cadenas a través de `AppLocalizations.of(context)!`.

> En este repo ya están versionados los archivos generados para ES/EN/IT, pero lo ideal es **regenerarlos** cuando modifiques los ARB.

---

## Scripts útiles

```bash
# Formatear código
dart format .

# Análisis estático
dart analyze

# Generar localizaciones (si tienes l10n.yaml configurado)
flutter gen-l10n
```

---
