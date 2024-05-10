import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:odc_pro/screens/myapp.dart';

class SlidesPage extends StatefulWidget {
  const SlidesPage({super.key});

  @override
  State<SlidesPage> createState() => _SlidesPageState();
}

class _SlidesPageState extends State<SlidesPage> {
  late List<Widget> slideList;
  late PageController _pageController;
  late int slideInitIndex;
  int slidePageCount = 3;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    slideInitIndex = _pageController.initialPage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: GFIntroScreen(
              color: Colors.blueGrey,
              pageCount: slidePageCount,
              currentIndex: slideInitIndex,
              slides: slides(),
              pageController: _pageController,
              introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
                pageController: _pageController,
                pageCount: slideList.length,
                currentIndex: slideInitIndex,
                onForwardButtonTap: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                onBackButtonTap: () {
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear);
                },
                onDoneTap: () => Get.off(() => const MyApp()),
                onSkipTap: () => Get.off(() => const MyApp()),
                navigationBarColor: Colors.white,
                showDivider: false,
                inactiveColor: Colors.grey,
                activeColor: Color(0xFF33BBC5),
              ))),
    );
  }

  List<Widget> slides() {
    slideList = [
      Container(
        child: GFImageOverlay(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          color: Colors.orange,
          image: const AssetImage('assets/images/splash-1.jpg'),
          boxFit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: EdgeInsets.only(top: 70.0, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'BIENVENUE SUR ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontSize: 34)),
                    TextSpan(
                        text: ' SE-LO APP',
                        style: TextStyle(
                            color: Color.fromARGB(255, 34, 45, 172),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            fontSize: 34)),
                  ]),
                ),
                const Text(
                  "Bienvenue dans l'application qui vous relie à votre environnement, peu importe où vous vous trouvez. Que vous soyez un étudiant curieux explorant une nouvelle université, un voyageur avide cherchant le meilleur restaurant de la ville, ou un touriste en quête de l'hôtel parfait, SE-LO APP est là pour vous guider",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              image: AssetImage('assets/images/splash-2.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
        child: Padding(
          padding: EdgeInsets.only(top: 70.0, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: ' SE-LO APP ',
                      style: TextStyle(
                          color: Color(0xFF33BBC5),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 24)),
                  TextSpan(
                      text: ' VOTRE GUIDE PARFAIT ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 24)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "La GUINEE est pleine de merveille, alors laissez vous guider par SE-LO APP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              image: AssetImage('assets/images/splash-3.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            image: DecorationImage(
              image: AssetImage('assets/images/splash-4.avif'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
            )),
        child: Padding(
          padding: EdgeInsets.only(top: 70.0, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: ' AVEC ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 28)),
                  TextSpan(
                      text: ' SE-LO APP',
                      style: TextStyle(
                          color: Color.fromARGB(255, 34, 45, 172),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                          fontSize: 28)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Explorons ensemble notre PARADIS la GUINEE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    return slideList;
  }
}
