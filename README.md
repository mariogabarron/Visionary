# Visionary 
A goal-tracking app to help users set clear objectives, stay consistent, and measure progress over time.
Built with Flutter and Firebase, focused on clean architecture, scalability, and a smooth mobile experience.
> [!NOTE]
> Visionary is a **personal project built for experimentation**, focusing on clean architecture and scalable mobile development practices.

![Descripción de la imagen](assets/images/VISIONARY.png)

---

## Why Visionary 
Most goal apps are either too simple (just checklists) or too complex (too many features, no clarity).
Visionary focuses on a clean flow: define a goal → break it into actionable steps → track progress → reflect and iterate.

---

## Key Features 
- Goal creation with description, priority and target dates
- Milestones / tasks to break goals into smaller steps
- Progress tracking (completion %, history, and basic insights)
- Firebase Authentication (secure sign-in)
- Cloud data sync (same account across devices)

---

## Tech Stack 
- **Flutter (Dart)** — cross-platform mobile development
- **Firebase**
  - Authentication
  - Firestore or Realtime Database (depending on the project setup)
  - Analytics (optional)
- **Architecture**: feature-based structure + separation of concerns

---

## Architecture & Design 
Visionary is structured to be maintainable and team-friendly:
- **Feature-based folders** (each feature owns its UI, logic, and data layer)
- **Separation of concerns** between presentation, domain, and data
- **Reusable UI components** to keep the design consistent
- **Testability** in mind (domain logic isolated from UI)

---

## Roadmap 
- [ ] Reminders and habit loops (notifications)
- [ ] Better analytics dashboard (personal insights)
- [ ] Offline-first improvements


## Organización del repositorio

- `lib/`: aplicación Flutter (vistas, servicios, rutas y utilidades).
- `assets/`: imágenes y recursos.
- `test/`: pruebas automatizadas.
- `docs/`: revisión técnica y documentación de arquitectura.
- `config/`: configuración auxiliar del splash.
- `backups/`: respaldos históricos conservados, excluidos del análisis Dart.
- `android/`, `ios/`, `macos/`, `linux/`, `windows/`, `web/`: proyectos de plataforma.

`pubspec.yaml`, `pubspec.lock`, `analysis_options.yaml` y `firebase.json`
permanecen en la raíz para su descubrimiento automático por las herramientas.
La configuración Firebase de iOS está en `ios/Runner/GoogleService-Info.plist`,
con la referencia de Xcode actualizada. El archivo de DevTools sin ajustes activos
se conserva en `backups/devtools_options.yaml`.
`build/` y `.dart_tool/` son directorios generados e ignorados por Git.

Para regenerar el splash, ejecutar desde la raíz:

```sh
dart run flutter_native_splash:create --path=config/native_splash.yaml
```

Documentación: [revisión técnica](docs/limpieza-tecnica.md),
[especificación](docs/arquitectura/Especificacion.md) y
[usuario](docs/arquitectura/Usuario.md).


### Vista del explorador en VS Code

Los manifiestos necesarios se muestran en el explorador. Solo se ocultan carpetas
generadas y metadatos de Flutter mediante `files.exclude` en `.vscode/settings.json`.
