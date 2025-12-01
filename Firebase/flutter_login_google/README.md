# Flutter Firebase Auth con Roles (Google + Email)

Este proyecto es una aplicación de ejemplo en **Flutter** que implementa
un sistema completo de autenticación de usuarios usando **Firebase**,
con:

- Login con **Google**
- Login y registro con **Email / Password**
- Recuperación de contraseña
- Manejo de sesión con **Riverpod**
- **Roles de usuario** almacenados en **Cloud Firestore**
- Navegación condicional según el rol (`admin` / `user`)
- Visualización del **Firebase ID Token (JWT)**
- Carga de avatar usando **CachedNetworkImage**

---

## 🧩 Características principales

✔ Autenticación con Google\
✔ Registro e inicio de sesión por email\
✔ Restablecimiento de contraseña\
✔ Control de sesión centralizado (Riverpod)\
✔ Persistencia de roles en Firestore\
✔ Separación de pantallas por rol\
✔ Obtención del JWT del usuario autenticado\
✔ Avatar dinámico desde Google Profile

---

## 🛠️ Tecnologías y librerías

- **Flutter**
- **firebase_core** -- inicialización Firebase
- **firebase_auth** -- autenticación de usuarios
- **cloud_firestore** -- almacenamiento del rol
- **flutter_riverpod** -- manejo de estado
- **cached_network_image** -- carga de imágenes

Dependencias aproximadas:

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^6.0.0
  flutter_riverpod: ^3.0.0
  cached_network_image: ^3.3.0
```

---

## 📁 Estructura del proyecto

Solo se documenta la carpeta `lib/`, ya que el resto corresponde a la
estructura estándar de Flutter.

    lib/
    ├─ main.dart
    ├─ firebase_options.dart
    └─ features/
       └─ auth/
          ├─ controller/
          │  └─ auth_controller.dart
          ├─ data/
          │  ├─ models/
          │  │  └─ app_user.dart
          │  └─ repositories/
          │     └─ auth_repository.dart
          └─ presentation/
             ├─ pages/
             │  ├─ login_screen.dart
             │  ├─ admin_home.dart
             │  └─ user_home.dart
             └─ widgets/
                └─ user_avatar.dart

---

## 📌 Descripción de módulos

### `main.dart`

- Inicializa Firebase (`Firebase.initializeApp()`).
- Inyecta Riverpod con `ProviderScope`.
- Observa el `AuthController` para decidir qué vista renderizar:
  - `LoginScreen` → usuario no autenticado.
  - `AdminHome` → usuario con rol `admin`.
  - `UserHome` → cualquier otro rol.

---

### `auth_controller.dart`

Controlador principal (Riverpod `AsyncNotifier`).

Responsabilidades: - Escuchar el estado de autenticación de Firebase. -
Obtener el **ID Token (JWT)** del usuario autenticado. - Consultar
Firestore para recuperar el **rol**. - Construir el modelo `AppUser`. -
Exponer métodos:

```dart
signInWithGoogle()
signInWithEmail()
registerWithEmail()
sendPasswordReset()
signOut()
```

---

### `auth_repository.dart`

Capa de acceso a datos.

Funciones: - Integración con **FirebaseAuth** para login. -
Escritura/lectura de documentos en **Firestore**. - Creación del
documento del usuario al registrarse:

```json
{
  "role": "user"
}
```

---

### `app_user.dart`

Modelo de dominio del usuario autenticado:

Atributos: - `uid` - `email` - `displayName` - `photoUrl` - `role` -
`idToken`

Helper:

```dart
bool get isAdmin => role == 'admin';
```

Incluye constructor de conveniencia `AppUser.fromFirebase()`.

---

### Pantallas

#### `login_screen.dart`

- Formulario de email + contraseña.
- botón de registro.
- botón de login con Google.
- opción de recuperación de contraseña.
- muestra errores del controlador.

---

#### `admin_home.dart`

- Vista exclusiva para administradores.
- Información del usuario.
- Muestra JWT.
- Avatar.
- Cerrar sesión.

---

#### `user_home.dart`

- Vista base para usuarios estándar.
- Avatar.
- Rol asignado.
- Botón de logout.

---

#### `user_avatar.dart`

Widget reutilizable:

- Normaliza la URL del perfil de Google.
- Descarga la imagen con caché mediante `CachedNetworkImage`.
- Fallback a ícono por defecto.

---

---

## 🔄 Flujo de funcionamiento

1.  App inicia → Firebase se inicializa.
2.  Riverpod consulta `authStateChanges()`.
3.  Usuario:
    - No logueado → `LoginScreen`.
    - Logueado → Se solicita JWT.
4.  Repository:
    - Consulta Firestore → obtiene `role`.
5.  Controller:
    - Construye `AppUser`.
6.  UI:
    - Enruta a `AdminHome` o `UserHome`.

---

## 🔐 Firestore -- Roles

Colección:

    /users/{uid}

Documento básico:

```json
{
  "role": "user"
}
```

Valor posibles: - `"user"` → rol por defecto. - `"admin"` → acceso
total.

### Convertir un usuario a administrador

1.  Entrar a Firebase Console → Firestore.
2.  Abrir `/users/{uid}`.
3.  Cambiar:

```json
{
  "role": "admin"
}
```

---

## ⚙️ Configuración Firebase

Instalar FlutterFire:

```bash
dart pub global activate flutterfire_cli
```

Vincular proyecto:

```bash
flutterfire configure
```

Esto genera:

    lib/firebase_options.dart

Archivo requerido para conectar la app con Firebase.

---

## ▶️ Ejecutar la aplicación

```bash
flutter pub get
flutter run
```
