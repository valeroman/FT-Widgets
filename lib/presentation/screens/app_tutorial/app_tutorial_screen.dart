import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo('Busca la comida', 'Et sit non commodo commodo nisi in ut velit eu. Amet sunt est eiusmod ipsum dolore. Consectetur eiusmod ad nisi amet excepteur magna. Ad velit aliquip incididunt enim nisi dolore pariatur irure qui cillum.', 'assets/images/1.png'),
  SlideInfo('Entrega rapida', 'Do commodo deserunt consectetur aute do aliquip id adipisicing irure quis irure. Occaecat et non sit anim aliqua in nisi laboris nostrud dolore laboris minim culpa. Deserunt occaecat nostrud irure sit magna anim duis. Tempor est eu minim qui excepteur commodo culpa aute cupidatat cillum laboris enim laborum in. Ullamco commodo magna sit sunt et. Ipsum sint tempor anim commodo ea magna. Mollit tempor labore magna qui adipisicing esse esse consequat deserunt anim non.', 'assets/images/2.png'),
  SlideInfo('Disfruta la comida', 'Cupidatat consequat ut id duis ut ullamco. Et commodo mollit tempor ea laboris velit laborum deserunt ex. Do elit quis nulla amet non non officia elit consectetur ipsum eiusmod in culpa. Qui elit velit labore do excepteur sit.', 'assets/images/3.png'),
];


class AppTutorialScreen extends StatefulWidget {

  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {

  // Propiedad
  final PageController pageviewController = PageController();
  bool endReached = false;

  // agregar un listener al pageController con un initState
  @override
  void initState() {
    super.initState();

    // NO emite nada
    pageviewController.addListener(() {
      final page = pageviewController.page ?? 0;
      if (!endReached && page >= (slides.length - 1.5)) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageviewController,
            physics: const BouncingScrollPhysics(),
            children: slides.map(
              (slideData) => _Slide(
                title: slideData.title, 
                caption: slideData.caption, 
                imageUrl: slideData.imageUrl
              )
            ).toList(),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              child: const Text('Salir'),
              onPressed: () => context.pop(),
            )
          ),
          
          endReached ? 
            Positioned(
              bottom: 30,
              right: 30,
              child: FadeInRight(
                from: 15, // que solo se mueva 15 unidades
                delay: const Duration(seconds: 1),
                child: FilledButton(
                  onPressed: () => context.pop(),
                  child: const Text('Comenzar'),
                ),
              )
            ): const SizedBox()
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

    final String title;
    final String caption;
    final String imageUrl;

    const _Slide({
      required this.title, 
      required this.caption, 
      required this.imageUrl
    });
  
    @override
    Widget build(BuildContext context) {

      final titleStyle = Theme.of(context).textTheme.titleLarge;
      final captionStyle = Theme.of(context).textTheme.bodySmall;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imageUrl)),
            const SizedBox(height: 20),
            Text(title, style: titleStyle,),
            const SizedBox(height: 20),
            Text(caption, style: captionStyle,)
          ],
        ),
      );
    }
  }