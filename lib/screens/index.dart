import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/screens/categorie.dart';
import 'package:odc_pro/screens/lieu.dart';
import 'package:odc_pro/screens/listFeedback.dart';
import 'package:odc_pro/screens/profil.dart';
import 'package:odc_pro/widgets/bottomSheetContent.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

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
      const ProfilPage(),
      listFeedBack(),
      categoryPage(context, setState: setState), 
      lieuPage(context, setState: setState),
      // profilPage(context, setState: setState),
      // categoryPage(context, setState: setState),
      // lieuPage(context, setState: setState),
      // const FeekBack()
    ];
    return SafeArea(
      child: Scaffold(
        body: pages[pageIndex],
        
     floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF33BBC5),
        child: const Icon(Icons.add),
        onPressed: () {
                Get.bottomSheet(AdminBottonSheet(typeAction: "add"));
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      
      bottomNavigationBar: BottomAppBar(
        height: 90,
        padding: const EdgeInsets.only(bottom: 0,left: 0,right: 0,top: 0),
        color: const Color(0xFF33BBC5),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          clipBehavior: Clip.antiAlias,

        child: Container(
          width: double.infinity,
          height: double.infinity,
          
          color: const Color(0xFF33BBC5),
          child: BottomNavigationBar(
            iconSize: 30,
          elevation: 35,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xFF001B79),
          selectedFontSize: 16,
          unselectedFontSize: 14,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex,
            onTap: changePageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Compte"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.feedback),
                label: "Feedback"
              ),
              
              BottomNavigationBarItem(
                icon: Icon(Icons.type_specimen),
                label: "Type lieu"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                label: "Location"
              )
            ]
          ),
          
        ),
      ),
     //fin du bloc
      ),
    );
  }
}
