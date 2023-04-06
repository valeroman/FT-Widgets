import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  // Metodos
  void showCustomSnackbar(BuildContext context) {

    ScaffoldMessenger.of(context).clearSnackBars();

    final snackbar = SnackBar(
      content: const Text('Hola Mundo'),
      action: SnackBarAction(label: 'Ok', onPressed: () {}),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void openDialog(BuildContext context) {


    showDialog(
      context: context, 

      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(' Estas seguro?'),
        content: const Text('Aliquip duis sint ut aliquip eu. Sunt dolor consequat in velit sunt ea laborum eiusmod quis esse elit eu excepteur. Aliqua non duis consectetur aliqua nisi ad culpa non. Et aliquip duis aute qui duis ullamco fugiat. Reprehenderit magna ad adipisicing commodo est ullamco aliquip.'),
        actions: [
          TextButton(onPressed: () =>  Navigator.of(context).pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: () =>  Navigator.of(context).pop(), child: const Text('Aceptar'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y diálogos'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  children: [
                    const Text('Do voluptate elit elit ullamco cupidatat adipisicing nisi in sit sint aliqua excepteur. Nulla non esse incididunt Lorem ex id. Incididunt magna sint et do consequat nulla adipisicing culpa occaecat veniam. Dolor consequat dolore commodo consequat reprehenderit deserunt id tempor qui in laborum laborum qui. Mollit cupidatat elit aute proident incididunt exercitation. Aliquip id sunt ullamco cupidatat est culpa.')
                  ]
                );
              }, 
              child: const Text('Licencias usadas'),
            ),

            FilledButton.tonal(
              onPressed: () => openDialog(context), 
              child: const Text('Mostrar diálogo'),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCustomSnackbar(context), 
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
      ),
    );
  }
}