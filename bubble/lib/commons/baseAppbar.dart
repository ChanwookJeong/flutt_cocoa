import 'package:flutter/material.dart';
import '../screens/chat_screen.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar(
      {Key? key,
      required this.appBar,
      required this.title,
      this.center = false})
      : super(key: key);

  final AppBar appBar;
  final String title;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent[300],
      centerTitle: true,
      elevation: 0.0,
      title: Text(
        '$title',
        style:
            TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
      ),
      actions: [
        //메세지 알림
        IconButton(
          icon: Icon(
            Icons.place,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        //chat
        // IconButton(
        //   icon: Icon(
        //     Icons.chat_outlined,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => const ChatScreen()));
        //   },
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
