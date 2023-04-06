# widgets_app

A new Flutter project.

### go_router Navegar entre pantallas
Documentacion: https://pub.dev/documentation/go_router/latest/

- En la carpeta `lib -> config -> router`, creamos el archivo `app+router.dart` y colocamos el siguiente código:

```
import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens/screens.dart';


// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),

    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    ),

  ],
);
```

- El archivo `main.dart` quedaria asi:
```
import 'package:flutter/material.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme( selectedColor: 9 ).getTheme(),
    );
  }
}

```

- Y para realizar la navegación a otra pantalla desde el `home_scren.dart` al `buttons_screen.dart`:

```
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {

  const _HomeView();

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];

        return _CustomListTile(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {

  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: color.primary),
      trailing: Icon(Icons.arrow_forward_ios_outlined, color: color.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        //? Navegacion de pantallas
        //  Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const ButtonsScreen(),
        //   ),
        // );
        // Navigator.pushNamed(context, menuItem.link);

        context.push(menuItem.link);
      },
    );
  }
}
```

## Riverpod
Documentacion: https://docs-v2.riverpod.dev/docs/getting_started

- en el archivo `counter_screen.dart` colocamos el siguiente código:
```
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {

  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Valor: 10', style: Theme.of(context).textTheme.titleLarge,)
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

```

- Instalacción: `flutter_riverpod`.
- En el archivo `main.dart`, colocar lo siguiente `ProviderScope`:
```
void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    )
    
  );
}
```
- Con ese widget `ProviderScope`, Riverpod va a saber donde buscar cada uno de nuestros providers de riverpod que crearemos.

- Crear la carpeta en `lib -> presentation -> providers`
- Creamos el archivo `counter_provider.dart` y agregamos lo siguiente:
```
// StateProvider => es un proveedor de un estado
final counterProvider = StateProvider<int>((ref) => 5);
```
- Ahora cambiamos el `StatelessWidget` por `ConsumerWidget` y agregamos en el `Widget build(BuildContext context)` el `Widget build(BuildContext context, WidgetRef ref)`
- Para mostrar el valor del `counter_provider`, agregamos ` final int clickCounter = ref.watch(counterProvider);` y `Text('Valor: $clickCounter', style: Theme.of(context).textTheme.titleLarge,)`

```
@override
  Widget build(BuildContext context, WidgetRef ref) {

    // Estar pendiente del counterProvider si cambia con el ref.watch(counterProvider)
    final int clickCounter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Valor: $clickCounter', style: Theme.of(context).textTheme.titleLarge,)
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
```
- Para cambiar el valo al hacer click en el boton agregamos lo siguiente:
```
floatingActionButton: FloatingActionButton(
  onPressed: () {
    // No usar el watch en metodos, usr el read
    // Para hacer un cambio en el estado usamos => .notifier
    
    // ref.read(counterProvider.notifier)
    //   .update((state) => state + 1);
    ref.read(counterProvider.notifier).state++;
  },
  child: const Icon(Icons.add),
),
```
