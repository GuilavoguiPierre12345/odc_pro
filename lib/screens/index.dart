import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:odc_pro/models/categorie.dart';
import 'package:odc_pro/screens/categorie.dart';
import 'package:odc_pro/screens/lieu.dart';
import 'package:odc_pro/screens/profil.dart';
import 'package:odc_pro/widgets/widget_pages/feekback.dart';

class IndexPage extends StatefulWidget {
  IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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


  int pageIndex = 0;
  changePageIndex(int newPageIndex) {
    setState(() {
      pageIndex = newPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      profilPage(context, setState: setState),
      categoryPage(context, setState: setState),
      lieuPage(context, setState: setState),
      const FeekBack()
    ];

    return SafeArea(
      child: Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          //============= mise en forme =============
          iconSize: 30,
          backgroundColor: Colors.transparent,
          elevation: 35,
          selectedItemColor: const Color(0xFF33BBC5),
          unselectedItemColor: const Color(0xFF001B79),
          selectedFontSize: 16,
          unselectedFontSize: 14,
          //=========================================
          onTap: changePageIndex,
          currentIndex: pageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.person_2_outlined),
              ),
              label: 'Compte',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.category),
              ),
              label: 'Type lieu',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('5'),
                child: Icon(Icons.location_on),
              ),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('51'),
                child: Icon(Icons.feedback),
              ),
              label: 'Feedbacks',
            ),
          ],
        ),
      ),
    );
  }
}
