# Clase 5 — Starter para estudiantes

Este proyecto contiene únicamente la base necesaria para trabajar durante la clase.

## Archivos

- `lib/main.dart`: punto de entrada de la aplicación.
- `lib/movie.dart`: modelo `Movie`.
- `lib/movie_screen.dart`: pantalla que evolucionará durante los checkpoints.

## Cómo usarlo

1. Crea un proyecto Flutter nuevo:

   ```bash
   flutter create clase5_movies
   ```

2. Reemplaza la carpeta `lib/` del proyecto por la carpeta `lib/` incluida aquí.

3. Desde la raíz del proyecto ejecuta:

   ```bash
   flutter run
   ```

Al iniciar debes ver una pantalla con el título **Películas** y un botón **Cargar películas**.

## Importante

No completes `fetchMovies()` ni `_buildBody()` antes de la actividad.
La intención es construir la solución progresivamente durante la clase y comprender:

`estado → setState → async/await → datos/error → reconstrucción de UI`
