# Nextep - Flutter Technical Test

¡Hola! Mi nombre es Nestor Gonzalez y este repositorio corresponde a mi solución del reto técnico Flutter propuesto por Nextep.

## 🏗 Arquitectura y Decisiones Técnicas

Opté por una arquitectura basada en separación de responsabilidades y principios de escalabilidad y mantenibilidad:

- **API Client** (`api_client.dart`): Centraliza la configuración y el acceso HTTP, evitando URLs "quemadas" y permitiendo fácil reutilización.
- **Services** (`breed_service.dart`): Encapsulan la lógica de consumo y manejo de datos remoto (API `catfact.ninja`). Aquí manejo los errores y mapeo los datos crudos a modelos tipados.
- **Modelos** (`breed_model.dart`): Permiten trabajar con datos fuertemente tipados en vez de `Map<String, dynamic>`, garantizando consistencia y facilitando testing.
- **BLoC** (`blocs/`): Usé el patrón BLoC (Business Logic Component) para manejar el estado y lógica de negocio, completamente aislado de la UI. Implementé eventos y estados separados tanto para el listado como para los detalles de razas.
- **Helpers** (`debounce_transformer.dart`): Para optimizar la paginación, incluí lógica de debounce y transformación de eventos en el BLoC para evitar saturar la API durante el scroll rápido.
- **Screens y Widgets**: Separé las pantallas y los widgets, incluyendo placeholders con skeleton loaders para mejorar la experiencia durante la carga inicial.

**Justificación:**  
Esta arquitectura me permitió mantener el código organizado, limpio y escalable. Cada capa tiene responsabilidad única y clara, facilitando el testing y futuras modificaciones. Aunque es mi primera vez usando BLoC, encontré que, a diferencia de Provider/GetX que he usado antes, BLoC "me obliga" a llevar una estructura ordenada desde el inicio, con tipados fuertes y un flujo de eventos/estados que le da robustez a la lógica de la app. El boilerplate inicial es mayor, pero la claridad y el control adquirido lo justifican.

## 🔄 Manejo de Estado & Paginación (BLoC)

- Toda la lógica de paginación y fetch de datos está aislada en el `breeds_bloc.dart`, evitando cualquier mezcla de lógica con la UI.
- Implementé estados de carga, éxito y error de manera explícita.
- La paginación agrega nuevos elementos a la lista existente usando `nueva_lista = [...lista_vieja, ...nuevos_datos]`.
- Usé un **droppable** para evitar múltiples fetchs simultáneos en scroll rápido; los eventos de scroll extra son ignorados si hay una petición en curso.

> **Aprendizaje Personal:**  
> Vengo de usar Provider y GetX, pero nunca había hecho Infinite Scroll con BLoC. Me costó entender los Yields y Emits, así que dediqué tiempo a leer la documentación oficial y recursos adicionales. Al final, logré una implementación funcional, y me pareció interesante cómo la exigencia de organización me ayudó a tener una arquitectura limpia y tipada. Sin duda, este conocimiento suma mucho a mi perfil.

## 🌐 Consumo de API y Capa de Datos

- Las peticiones HTTP se manejan desde la capa de servicios (`breed_service.dart`), sin "quemar" URLs en la UI ni en los widgets.
- Los datos se transforman con `BreedModel` usando un método `fromJson`.
- Se gestionan los errores de red y deserialización a nivel de servicio/repository, retornando resultados tipados para que el BLoC decida acciones y estados según la respuesta.

## 🖼 UI, UX & Manejo de Errores

- Si hay problemas de red o errores en la carga, la aplicación nunca muestra una pantalla gris ni la "pantalla roja de la muerte".  
- Se muestra un mensaje claro en pantalla informando al usuario sobre el error y permitiendo reintentar la acción según el caso.
- Implementé indicadores de carga (`CircularProgressIndicator`) y skeleton loaders personalizados para mejorar la experiencia en la carga inicial.

> **Justificación por ausencia de SnackBars:**  
> Por razones de tiempo y enfoque en los pilares principales de la prueba, no pude implementar SnackBars para mostrar mensajes de error. Sin embargo, me aseguré de que la aplicación siempre informe correctamente al usuario los problemas, sin dejar la pantalla vacía o en estados erróneos. En futuras iteraciones considero agregar SnackBars como una mejora UX importante.

## 💎 Actitud y Proceso

Mi enfoque fue honesto y orientado a aprender bajo presión.  
Reconozco que es mi primera vez con BLoC, lo que exigió lectura y práctica adicional. Me adapté rápido a la nueva herramienta gracias a mi experiencia previa con otras soluciones de manejo de estado.

**Áreas de mejora:** Si tuviera más tiempo, añadiría:
- SnackBars para mejorar la comunicación visual de errores y acciones.
- Mejor manejo de errores con clases envolventes (Result/Either).
- Más tests unitarios y de integración.
- Skeleton loaders animados y feedback optimizado en caso de error de red en paginación.

## 🚀 ¿Cómo ejecutar la aplicación?

```bash
flutter pub get
flutter run
```

## 🗄 Estructura de Carpetas

```
lib/
├── api_client.dart
├── blocs
│   ├── breeds_bloc.dart
│   ├── breeds_detail_bloc.dart
│   ├── breeds_detail_event.dart
│   ├── breeds_detail.state.dart
│   ├── breeds_event.dart
│   └── breeds_state.dart
├── helpers
│   └── debounce_transformer.dart
├── main.dart
├── models
│   └── breed_model.dart
├── screens
│   ├── breed_detail_screen.dart
│   ├── breeds_screen.dart
│   └── widgets
│       ├── breed_row_skeleton.dart
│       └── breed_skeleton.dart
└── services
    └── breed_service.dart
```

---

## 🙋‍♂️ Contacto

Si tienes dudas o feedback, puedes contactarme por GitHub o LinkedIn.

---

¡Gracias por tu tiempo y por considerar mi candidatura!