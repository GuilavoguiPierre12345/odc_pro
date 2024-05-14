import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/screens/login.dart';
import 'package:odc_pro/widgets/adminListItem.dart';


class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List users = [] ;
  bool isLogin=true;
  Future<void> recupererUtilisateurs() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('admin').get();

     

    // Parcourir les documents récupérés
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      setState(() {
           isLogin=false;
           users.add(document.data());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    recupererUtilisateurs();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 6,
          decoration: const BoxDecoration(color: Color(0xFF33BBC5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Ajouter un admin",
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      // border: Border.all(color: Colors.white, width: 2.0)
                      
                      ),
                  child: IconButton(
                      onPressed: () {
                        Get.off(const LoginPage());
                      },
                      icon: const Icon(Icons.logout),style: const ButtonStyle(iconSize:MaterialStatePropertyAll(40),),),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Liste des administrateurs",
            style: TextStyle(color: Color(0xFF33BBC5), fontSize: 22),
          ),
        ),
        
        isLogin?const Center(
          child: CircularProgressIndicator(),
        ): Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("admin").snapshots(),
            builder: (context,snap){
                 if(snap.hasError){
              return const Center(child: Text("Error"),);
            }
            if(snap.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            List<Map<String,dynamic>> admin=[];
            snap.data!.docs.forEach((element) {
              admin.add(element.data() as Map<String,dynamic>);
            });
            return ListView.builder(
              itemCount: admin.length,
              itemBuilder: (context,index){
                return AdminList(user: admin[index], id: '');

              }
              
              
              );
            })
        )
      ],
    );
  }
}

// ListView(
//             shrinkWrap: true,
//             children: List.generate(users.length, (index) {
//               return AdminList(
//                 user: users[index],
//                 id: '',
//               );
//             }),
//           ),

// Widget profilPage(BuildContext context, {required Function setState}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.width / 6,
//         decoration: const BoxDecoration(color: Color(0xFF33BBC5)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(left: 8.0),
//               child: Text(
//                 "Ajouter un admin",
//                 style: TextStyle(color: Colors.white, fontSize: 24.0),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(50)),
//                     border: Border.all(color: Colors.white, width: 2.0)),
//                 child: IconButton(
//                     onPressed: () {
//                       Get.bottomSheet(addAdminBottomSheet(typeAction: "add"));
//                     },
//                     icon: const Icon(Icons.add)),
//               ),
//             ),
//           ],
//         ),
//       ),
//       const Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           "Liste des administrateurs",
//           style: TextStyle(color: Color(0xFF33BBC5), fontSize: 22),
//         ),
//       ),
//       Expanded(
//         child: ListView(
//           shrinkWrap: true,
//           children: List.generate(2, (index) {
//             return AdminList(user:users,id: '',);
//           }),
//         ),
//       )
//     ],
//   );
// }
