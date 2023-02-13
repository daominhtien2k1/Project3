import 'package:chat_messenger/responsive.dart';
import 'package:chat_messenger/screens/chat_detail_screen.dart';
import 'package:chat_messenger/screens/chat_list_screen.dart';
import 'package:chat_messenger/screens/rich_text_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'Dao Minh Tien';
  handleChangeDetailChatContent (String name) {
    setState(() {
      this.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Responsive(
          mobile: ChatListScreen(),
          tablet: Row(
            children: [
              Expanded(flex: _size.width > 1340 ? 1 : 2, child: ChatListScreen(onChangeDetailChatContent: (name) => handleChangeDetailChatContent(name))),
              VerticalDivider(color: Colors.grey, width: 2, thickness: 2),
              Expanded(flex: _size.width > 1340 ? 4 : 6, child: ChatDetailScreen(name: name))
            ],
          ),
          desktop: Row(
            children: [
              Expanded(flex: _size.width > 1340 ? 2 : 2, child: ChatListScreen(onChangeDetailChatContent: (name) => handleChangeDetailChatContent(name))),
              VerticalDivider(color: Colors.grey, width: 2, thickness: 2),
              Expanded(flex: _size.width > 1340 ? 3 : 4, child: ChatDetailScreen(name: name)),
              VerticalDivider(color: Colors.grey, width: 2, thickness: 2),
              Expanded(flex: _size.width > 1340 ? 6 : 4, child: RichTextScreen())
            ],
          )
        )
    );
  }
}
