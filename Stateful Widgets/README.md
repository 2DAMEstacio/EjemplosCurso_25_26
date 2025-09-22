# 🐦 Ejemplo de StatefulWidgets en Flutter

Este proyecto es una práctica sencilla para aprender y poner en uso **widgets con estado** en Flutter.  
El ejemplo simula un mini–timeline de Twitter con una lista de tweets ficticios que se pueden visualizar, dar “like” y “retweet”.

---

## 🎯 Objetivos de la práctica

- Comprender la diferencia entre **StatelessWidget** y **StatefulWidget**.
- Practicar el uso de `setState()` para actualizar la interfaz de usuario.
- Manejar listas dinámicas (`ListView.builder`).
- Pasar datos y callbacks entre widgets (`TweetCard` y `TweetList`).
- Trabajar con datos simulados (_dummy data_).

---

## 📂 Estructura del proyecto

```
lib/
 ├── main.dart
 ├── data/
 │    ├── dummy/
 │    │    └── dummy_tweets.dart   # Datos de prueba (lista de tweets con likes y retweets)
 │    └── models/
 │         └── tweet.dart          # Clase modelo Tweet
 └── presentation/
      └── widgets/
           ├── tweet_card.dart     # Widget que muestra un tweet individual
           └── tweet_list.dart     # Widget que construye la lista completa de tweets
```

---

## 🛠️ Descripción de los archivos

### `main.dart`

Punto de entrada de la aplicación. Configura el `MaterialApp` y muestra la pantalla principal con la lista de tweets.

### `data/dummy/dummy_tweets.dart`

Contiene una lista de mapas con tweets ficticios, incluyendo:

- `id`
- `user`
- `content`
- `timestamp`
- `likes`
- `retweets`

Sirve como **fuente de datos inicial**.

### `data/models/tweet.dart`

Define la clase **Tweet**, que estructura los datos de cada tweet.  
Incluye métodos para:

- Crear un objeto desde un `Map` (`fromMap`).
- Convertir un objeto en `Map` (`toMap`).
- `toString()` para depuración.

### `presentation/widgets/tweet_card.dart`

Representa un **tweet individual** en pantalla:

- Muestra usuario, contenido, fecha.
- Tiene botones de **like** y **retweet** con sus contadores.
- Recibe callbacks para manejar interacciones.

### `presentation/widgets/tweet_list.dart`

Es un **StatefulWidget** que gestiona la lista de tweets:

- Inicializa la lista con los datos de `dummy_tweets.dart`.
- Construye la lista con `ListView.builder`.
- Implementa funciones `_onLike` y `_onRetweet` para actualizar el estado.

---

## ▶️ Ejecución

1. Asegúrate de tener Flutter instalado y configurado.
2. Clona o descarga este repositorio.
3. Instala dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la app:
   ```bash
   flutter run
   ```

---

## 🚀 Posibles extensiones

- Añadir funcionalidad para **crear un nuevo tweet**.
- Implementar la eliminación de tweets.
- Añadir un buscador para filtrar tweets.
- Mejorar la UI con fotos de perfil o animaciones en los botones.
- Usar `Dismissible` para borrar tweets deslizando.

---

## 📚 Lo que aprendes con esta práctica

- Cómo declarar y usar **StatefulWidgets** en Flutter.
- Actualización de la interfaz con `setState`.
- Manejo de **listas dinámicas** y renderizado eficiente con `ListView.builder`.
- Separación de responsabilidades (modelo de datos, widgets de presentación, datos dummy).
