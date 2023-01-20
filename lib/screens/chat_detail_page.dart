import 'dart:convert';

import 'package:chat_messenger/constants/data.dart';
import 'package:chat_messenger/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late TextEditingController _sendMessageController;
  late QuillController _controller;
  bool isTextSend = false;
  late FocusNode myFocusNode;
  late bool isMinimize;
  bool isEditing = false;
  @override
  void initState() {
    super.initState();
    _sendMessageController = new TextEditingController();
    _controller = QuillController.basic();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      // print("Focus: ${myFocusNode.hasFocus.toString()}");
      if(myFocusNode.hasFocus) {
        setState(() {
          isMinimize = true;
        });
      }else{
        setState(() {
          isMinimize = false;
        });
      }
    });
    isMinimize = myFocusNode.hasFocus;
    _controller.document.changes.listen((event) {
      var length = _controller.document.length;
      if(length == 1) {
        setState(() {
          isTextSend = false;
        });
      }else{
        if(!isTextSend)
          setState(() {
            isTextSend = true;
          });
        if(!isMinimize)
          setState(() {
            isMinimize = true;
          });
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _sendMessageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("Rebuild: ${DateTime.now()}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey.withOpacity(0.2),
        elevation: 0,
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: primary,
            )),
        title: Row(
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
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Tyler Nix",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "Active now",
                  style: TextStyle(color: black.withOpacity(0.4), fontSize: 14),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          const Icon(
            Icons.phone,
            color: primary,
            size: 32,
          ),
          const SizedBox(
            width: 15,
          ),
          const Icon(
            Icons.videocam,
            color: primary,
            size: 35,
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
                color: online,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white38)),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: getBody(),
      bottomSheet: getBottom(),
    );
  }
  Widget getBottom(){
    return Container(
      // height: 80,
      // width: double.infinity,
      constraints: BoxConstraints(
          minHeight: 60,
          minWidth: double.maxFinite,
          maxHeight: 160),
      decoration: BoxDecoration(
        color: grey.withOpacity(0.4)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                isMinimize ?
                GestureDetector(
                    child: Icon(Icons.arrow_forward_ios, size: 35, color: primary),
                    onTap: () {
                        setState(() {
                          isMinimize = false;
                        });
                    },
                ) :
                Container(
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.add_circle, size: 35,color: primary),
                      SizedBox(width: 5),
                      Icon(Icons.camera_alt,size: 35,color: primary),
                      SizedBox(width: 5),
                      Icon(Icons.photo,size: 35,color: primary)
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                          // padding: const EdgeInsets.only(left: 12), //for TextField
                          padding: const EdgeInsets.only(left: 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: primary),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12.0) //                 <--- border radius here
                              ),
                            color: const Color(0xF4FFE3E6),
                          ),
                          // child: TextField(
                          //   keyboardType: TextInputType.multiline,
                          //   maxLines: null,
                          //   cursorColor: black,
                          //   autofocus: false,
                          //   focusNode: myFocusNode,
                          //   controller: _sendMessageController,
                          //   onChanged: (text) {
                          //     if(text.length == 0) {
                          //       setState(() {
                          //         isTextSend = false;
                          //       });
                          //     }else{
                          //       setState(() {
                          //         isTextSend = true;
                          //         isMinimize = true;
                          //       });
                          //     }
                          //   },
                          //   onTap: (){
                          //     setState(() {
                          //       isMinimize = true;
                          //     });
                          //   },
                          //   decoration: InputDecoration(
                          //     border: InputBorder.none,
                          //     hintText: "Aa",
                          //     suffixIcon: IconButton(
                          //         onPressed: (){
                          //           setState(() {
                          //             isEditing = !isEditing;
                          //           });
                          //         },
                          //         icon: Icon(Icons.text_format,color: primary,size: 35)
                          //     )
                          //   ),
                          // ),
                          child: QuillEditor(
                            controller: _controller,
                            readOnly: false,
                            focusNode: myFocusNode, // true for view only mode
                            autoFocus: false,
                            scrollController: ScrollController(),
                            expands: false,
                            scrollable: true,
                            minHeight: 50,
                            maxHeight: 100,
                            padding: const EdgeInsets.all(10),
                            placeholder: "Nhập tin nhắn",
                          ),
                        ),
                ),
                SizedBox(
                  height: 44.0,
                  width: 32.0,
                  child: IconButton(
                      onPressed: (){
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      iconSize: 44,
                      padding: EdgeInsets.all(0),
                      icon: Icon(Icons.text_format,color: primary)
                  ),
                ),
                SizedBox(width: 12),
                isTextSend ?
                SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: IconButton(
                      onPressed: (){
                        print(_controller.document.toPlainText());
                        // print(_controller.document.toDelta());
                        var json = jsonEncode(_controller.document.toDelta().toJson());
                        print(json);
                        var myJSON = jsonDecode(json);
                        print(Document.fromJson(myJSON).toPlainText());
                        myFocusNode.unfocus();
                      },
                      iconSize: 32,
                      padding: EdgeInsets.all(0),
                      icon: const Icon(Icons.send,color: primary)
                  ),
                ) :
                const Icon(Icons.thumb_up,size: 32,color: primary),
              ],
            ),
            isEditing ? QuillToolbar.basic(
              controller: _controller,
              iconTheme: QuillIconTheme(
                borderRadius: 14,
                iconSelectedFillColor: Colors.pinkAccent
              ),
              showDividers : false,
              showFontFamily : true,
              showFontSize : false,
              showBoldButton : true,
              showItalicButton : true,
              showSmallButton : false,
              showUnderLineButton : true,
              showStrikeThrough : false,
              showInlineCode : false,
              showColorButton : true,
              showBackgroundColorButton : false,
              showClearFormat : false,
              showAlignmentButtons : false,
              showLeftAlignment : false,
              showCenterAlignment : false,
              showRightAlignment : false,
              showJustifyAlignment : false,
              showHeaderStyle : false,
              showListNumbers : false,
              showListBullets : false,
              showListCheck : false,
              showCodeBlock : false,
              showQuote : false,
              showIndent : false,
              showLink : false,
              showUndo : true,
              showRedo : true,
              multiRowsDisplay : false,
              showDirection : false,
              showSearchButton : false,
            )
            : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ListView(
        padding: const EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 80),
        children: List.generate(messages.length, (index){
          return ChatBubble(isMe: messages[index]['isMe'], messageType: messages[index]['messageType'], message: messages[index]['message'], profileImg: messages[index]['profileImg'], time: messages[index]['time']);
        }),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  final String time;
  const ChatBubble({
    Key? key, required this.isMe, required this.profileImg, required this.message, required this.messageType, required this.time
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isMe){
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              time,
              style: Theme.of(context).textTheme.subtitle1?.apply(color: Colors.grey),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: getMessageType(messageType) 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: white,
                      fontSize: 17
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            profileImg),
                        fit: BoxFit.cover)),
              ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: getMessageType(messageType) 
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: black,
                      fontSize: 17
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            Text(
              time,
              style: Theme.of(context).textTheme.subtitle1?.apply(color: Colors.grey),
            ),

          ],
        ),
      );
    }
    
  }
  getMessageType(messageType){
    if(isMe){
      // start message
      if(messageType == 1){
        return const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // middle message
      else if(messageType == 2){
        return const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // end message
      else if(messageType == 3){
        return const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)
        );
      }
      // standalone message
      else{
        return const BorderRadius.all(Radius.circular(30));
      }
    }
    // for sender bubble
    else{
      // start message
        if(messageType == 1){
          return const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // middle message
        else if(messageType == 2){
          return const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // end message
        else if(messageType == 3){
          return const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
          );
        }
        // standalone message
        else{
          return const BorderRadius.all(Radius.circular(30));
        }
    }
  }
}
