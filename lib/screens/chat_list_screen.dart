import 'package:chat_messenger/constants/data.dart';
import 'package:chat_messenger/responsive.dart';
import 'package:chat_messenger/screens/chat_detail_screen.dart';
import './widgets/CustomCircleAvatar.dart';
import 'package:chat_messenger/theme/colors.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  final Function? onChangeDetailChatContent;
  ChatListScreen({this.onChangeDetailChatContent});

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Responsive.isMobile(context) ? FloatingActionButton(
          elevation: 5,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.camera),
          onPressed: () {},
        ) : null,
        bottomNavigationBar: Responsive.isMobile(context) ? BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 7.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home_filled, color: Colors.black45),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.manage_history, color: Colors.black45),
                onPressed: () {},
              ),
              SizedBox(width: 25),
              IconButton(
                icon: Icon(Icons.people, color: Colors.black45),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.black45),
                onPressed: () {},
              ),
            ],
          ),
        ) : null,
      ),
    );
  }

  Widget getBody() {
    return ListView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                            fit: BoxFit.cover)),
                  ),
                  const Text(
                    "Chats",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.edit)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  cursorColor: black,
                  controller: _searchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: black.withOpacity(0.5),
                      ),
                      hintText: "Search",
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (Responsive.isMobile(context)) StoryList(),
              const SizedBox(
                height: 30,
              ),
              MessageList(onChangeDetailChatContent: widget.onChangeDetailChatContent),
            ],
    );
  }
}

class StoryList extends StatelessWidget {
  const StoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: grey),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 33,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: 75,
                  child: Align(
                      child: Text(
                    'Your Story',
                    overflow: TextOverflow.ellipsis,
                  )),
                )
              ],
            ),
          ),
          Row(
              children: List.generate(userStories.length, (index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: <Widget>[
                        CustomCircleAvatar(avatarUrl: userStories[index]['img'], isOnline: userStories[index]['online'], isStory: userStories[index]['story']),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 75,
                          child: Align(
                              child: Text(
                            userStories[index]['name'],
                            overflow: TextOverflow.ellipsis,
                          )),
                        )
                      ],
                    ),
                  );
          }))
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final Function? onChangeDetailChatContent;
  MessageList({
    Key? key, this.onChangeDetailChatContent
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(userMessages.length, (index) {
        return InkWell(
          onTap: () {
            if(Responsive.isMobile(context))
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailScreen(name: 'Dao Minh Tien')));
            else {
              onChangeDetailChatContent?.call(userMessages[index]['name'] as String);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomCircleAvatar(avatarUrl: userMessages[index]['img'], isOnline: userMessages[index]['online'], isStory: userMessages[index]['story']),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userMessages[index]['name'],
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width/2,
                        child: Text(
                          userMessages[index]['message'],
                          style: userMessages[index]['seen']
                              ? Theme.of(context).textTheme.subtitle1?.apply(color: Colors.black54)
                              : Theme.of(context).textTheme.subtitle2?.apply(color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        userMessages[index]['seen']
                            ? const Icon(Icons.check, size: 15,)
                            : const SizedBox(height: 15, width: 15),
                        Text("${userMessages[index]['lastMsgTime']}")
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    userMessages[index]['hasUnSeenMsgs']
                        ? Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: myGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${userMessages[index]['unseenCount']}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                        : const SizedBox(
                            height: 25,
                            width: 25,
                        ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
