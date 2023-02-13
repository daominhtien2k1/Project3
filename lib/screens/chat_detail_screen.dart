import 'dart:collection';
import 'dart:convert';
import 'package:chat_messenger/constants/data.dart';
import 'package:chat_messenger/responsive.dart';
import 'package:chat_messenger/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

class ChatDetailScreen extends StatefulWidget {
  String name;
  ChatDetailScreen({required this.name});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late TextEditingController _sendMessageController;

  late HtmlEditorController controller;
  bool isTextSend = false;
  bool isMinimize = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _sendMessageController = new TextEditingController();
    controller = HtmlEditorController();
  }

  @override
  void dispose() {
    _sendMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("Rebuild: ${DateTime.now()}");
    String name = widget.name as String;
    return GestureDetector(
      onTap: () {
        // if (!kIsWeb) {
          setState(() {
            isMinimize = false;
          });
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: grey.withOpacity(0.2),
          elevation: 0,
          leading: Responsive.isMobile(context) ? TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: primary,
              )) : null,
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
                  Text(
                    name,
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
      ),
    );
  }

  Widget getBottom() {
    return Container(
      // height: 80,
      // width: double.infinity,
      constraints: BoxConstraints(
          minHeight: 60, minWidth: double.maxFinite, maxHeight: 160),
      decoration: BoxDecoration(color: grey.withOpacity(0.4)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  isMinimize
                      ? GestureDetector(
                          child: Icon(Icons.arrow_forward_ios,
                              size: 35, color: primary),
                          onTap: () {
                            setState(() {
                              isMinimize = false;
                            });
                          },
                        )
                      : Container(
                          child: Row(
                            children: const <Widget>[
                              Icon(Icons.add_circle, size: 35, color: primary),
                              SizedBox(width: 5),
                              Icon(Icons.camera_alt, size: 35, color: primary),
                              SizedBox(width: 5),
                              Icon(Icons.photo, size: 35, color: primary)
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
                        // borderRadius: BorderRadius.all(Radius.circular(
                        //         12.0) //
                        //     ),
                        color: const Color(0xFFE3E6),
                      ),
                      child: HtmlEditor(
                        controller: controller,
                        htmlEditorOptions: HtmlEditorOptions(
                            hint: 'Viết tin nhắn của bạn',
                            spellCheck: true,
                            shouldEnsureVisible: true,
                            autoAdjustHeight: true,
                            webInitialScripts: UnmodifiableListView([
                              WebScript(name: "editorBG", script: "document.getElementsByClassName('note-editable')[0].style.backgroundColor='#FFE3E6';"),
                              WebScript(name: "height", script: """
                      var height = document.body.scrollHeight;
                      window.parent.postMessage(JSON.stringify({"type": "toDart: height", "height": height}), "*");
                    """),
                            ])
                        ),
                        htmlToolbarOptions: HtmlToolbarOptions(
                          toolbarPosition: ToolbarPosition.custom,
                          //by default
                          toolbarType: ToolbarType.nativeScrollable,
                          //by default
                          onButtonPressed: (ButtonType type, bool? status,
                              Function? updateStatus) {
                            // print(
                            //     "button '${describeEnum(type)}' pressed, the current selected status is $status");
                            return true;
                          },
                          onDropdownChanged: (DropdownType type, dynamic changed,
                              Function(dynamic)? updateSelectedItem) {
                            print(
                                "dropdown '${describeEnum(type)}' changed to $changed");
                            return true;
                          },
                          mediaLinkInsertInterceptor:
                              (String url, InsertFileType type) {
                            // controller.insertNetworkImage(url);
                            print(url);
                            return true;
                          },
                          mediaUploadInterceptor:
                              (PlatformFile file, InsertFileType type) async {
                            print(file.name); //filename
                            print(file.size); //size in bytes
                            print(
                                file.extension); //file extension (eg jpeg or mp4)
                            return true;
                          },
                        ),
                        callbacks:
                        Callbacks(onBeforeCommand: (String? currentHtml) {
                          // print('html before change is $currentHtml');
                        }, onChangeContent: (String? changed) {
                          // print('content changed to $changed');
                          var length = changed?.length ?? 0;
                          // print(length);
                          if(length == 0) {
                            setState(() {
                              isTextSend = false;
                            });
                          }else{
                            setState(() {
                              isTextSend = true;
                              isMinimize = true;
                            });
                          }
                        }, onChangeCodeview: (String? changed) {
                          // print('code changed to $changed');
                        }, onChangeSelection: (EditorSettings settings) {
                          // print('parent element is ${settings.parentElement}');
                          // print('font name is ${settings.fontName}');
                        }, onDialogShown: () {
                          print('dialog shown');
                        }, onEnter: () {
                          // print('enter/return pressed');
                        }, onFocus: () {
                          print("FOCUS: TRUE");
                          setState(() {
                            isMinimize = true;
                          });
                        }, onBlur: () {
                          // print("FOCUS: FALSE");
                          // print(isMinimize);
                          // setState(() {
                          //   isMinimize = false;
                          // });
                        }, onBlurCodeview: () {
                          // print('codeview either focused or unfocused');
                        }, onInit: () {
                          // print('init');
                          controller.setFullScreen();
                          controller.evaluateJavascriptWeb("editorBG");
                        }, onKeyDown: (int? keyCode) {
                          // print('$keyCode key downed');
                          // print(
                          //     'current character count: ${controller.characterCount}');
                        }, onKeyUp: (int? keyCode) {
                          // print('$keyCode key released');
                        }, onMouseDown: () {
                          // print('mouse downed');
                        }, onMouseUp: () {
                          // print('mouse released');
                        }, onNavigationRequestMobile: (String url) {
                          // print(url);
                          return NavigationActionPolicy.ALLOW;
                        }, onPaste: () {
                          // print('pasted into editor');
                        }, onScroll: () {
                          // print('editor scrolled');
                        }),
                        otherOptions: OtherOptions(height: 60),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44.0,
                    width: 32.0,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                            isMinimize = true;
                          });
                        },
                        iconSize: 44,
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.text_format, color: primary)),
                  ),
                  SizedBox(width: 12),
                  isTextSend
                      ? SizedBox(
                          height: 32.0,
                          width: 32.0,
                          child: IconButton(
                              onPressed: () {
                                // print(_controller.document.toPlainText());
                                // // print(_controller.document.toDelta());
                                // var json = jsonEncode(_controller.document.toDelta().toJson());
                                // print(json);
                                // var myJSON = jsonDecode(json);
                                // print(Document.fromJson(myJSON).toPlainText());

                              },
                              iconSize: 32,
                              padding: EdgeInsets.all(0),
                              icon: const Icon(Icons.send, color: primary)),
                        )
                      : const Icon(Icons.thumb_up, size: 32, color: primary),
                ],
              ),
              isEditing
                  ? ToolbarWidget(
                      controller: controller,
                      htmlToolbarOptions: HtmlToolbarOptions(
                        toolbarPosition: ToolbarPosition.custom,
                        //required to place toolbar anywhere!
                        //other options
                        defaultToolbarButtons: [
                          FontSettingButtons(
                              fontSizeUnit: false, fontSize: false),
                          FontButtons(
                              clearAll: false,
                              strikethrough: false,
                              subscript: false,
                              superscript: false),
                          ColorButtons()
                        ],
                      ),
                     callbacks: null,
                    )
                  : SizedBox(),
            ],
          ),
        ),
    );
  }

  Widget getBody() {
    return ListView(
        padding:
            const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 80),
        children: List.generate(messages.length, (index) {
          return ChatBubble(
              isMe: messages[index]['isMe'],
              messageType: messages[index]['messageType'],
              message: messages[index]['message'],
              profileImg: messages[index]['profileImg'],
              time: messages[index]['time']);
        }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final int messageType;
  final String time;

  const ChatBubble(
      {Key? key,
      required this.isMe,
      required this.profileImg,
      required this.message,
      required this.messageType,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              time,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.apply(color: Colors.grey),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: primary, borderRadius: getMessageType(messageType)),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(color: white, fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
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
                      image: NetworkImage(profileImg), fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: grey, borderRadius: getMessageType(messageType)),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    message,
                    style: const TextStyle(color: black, fontSize: 17),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            Text(
              time,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.apply(color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }

  getMessageType(messageType) {
    if (isMe) {
      // start message
      if (messageType == 1) {
        return const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // middle message
      else if (messageType == 2) {
        return const BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // end message
      else if (messageType == 3) {
        return const BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30));
      }
      // standalone message
      else {
        return const BorderRadius.all(Radius.circular(30));
      }
    }
    // for sender bubble
    else {
      // start message
      if (messageType == 1) {
        return const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // middle message
      else if (messageType == 2) {
        return const BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // end message
      else if (messageType == 3) {
        return const BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30));
      }
      // standalone message
      else {
        return const BorderRadius.all(Radius.circular(30));
      }
    }
  }
}
