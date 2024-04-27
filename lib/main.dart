import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/screens/login.dart';
import 'package:odc_pro/widgets/widget_pages/cagegorie_detail.dart';
import 'package:odc_pro/widgets/widget_pages/categorie_widget.dart';
import 'package:odc_pro/widgets/widget_pages/detail_categorie_detail.dart';
import 'package:odc_pro/widgets/widget_pages/feekback.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int currentPage=0;
  Widget pageBody(BuildContext context) {
    switch (currentPage) {
      case 0:
        return Categorie_Widget();
      case 1:
        return FeekBack();
      case 2:
        return Categorie_detail();
      default:
        return Text('Erreur');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home:
              Scaffold(
                
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 35,
              selectedFontSize: 24,
              unselectedFontSize: 22,
              unselectedItemColor: Color(0xFF001B79),
              selectedItemColor:Color(0xFF33BBC5) ,
              currentIndex: currentPage,
              onTap: (value) {
                  setState(() {
                    currentPage=value;
                  });
              },
              items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.feedback),label: 'Feekback'),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profil'),
            
            ]),
            body: pageBody(context)
          ),
        ),
    );
  
  }
}
  
