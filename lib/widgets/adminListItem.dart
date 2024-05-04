import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odc_pro/widgets/bottomSheetContent.dart';

class AdminList extends StatefulWidget {
  // late int index;
  // Function updateState;
  Map <String,dynamic> user;
  String id;
  AdminList({super.key,required this.user,required this.id});
  
  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList>
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

  @override
  Widget build(BuildContext context) {
    return adminListItem(user:  widget.user,index: widget.id);
  }
}
// {required int index, required Function updateState}
Widget adminListItem({required Map<String,dynamic> user,required String index}) {
  return Card.outlined(
    elevation: 7.0,
    child: Dismissible(
      onDismissed: (direction) {
        Get.bottomSheet(AdminBottonSheet(typeAction: "maj",user: user));
      },
      background: Container(
        color: const Color(0xFF33BBC5),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.edit,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      key: Key("$user"),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("assets/images/image.jpeg"),
        ),
        title: Text("${user['nomcomplet']}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("${user['profession']}"), Text("${user['contact']}")],
        ),
      ),
    ),
  );
}


