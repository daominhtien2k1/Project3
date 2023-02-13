import 'package:chat_messenger/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

class RichTextScreen extends StatefulWidget {
  RichTextScreen({Key? key}) : super(key: key);

  @override
  State<RichTextScreen> createState() => _RichTextScreenState();
}

class _RichTextScreenState extends State<RichTextScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      shape: BoxShape.circle
                    ),
                  )
                ],
              ),
              const TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.cloud_outlined),
                      text: 'Chỉnh sửa',
                    ),
                    Tab(
                      icon: Icon(Icons.beach_access_sharp),
                      text: 'Xem trước',
                    ),
                    Tab(
                      icon: Icon(Icons.beach_access_sharp),
                      text: 'Danh sách',
                    )
                  ],
                  indicatorColor: primary,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black
              ),
              Expanded(
                  child: TabBarView(
                    children: [
                      EditRichTextDocument(),
                      ViewRichTextDocument(),
                      ViewRichTextDocument()
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}

class EditRichTextDocument extends StatefulWidget {
  @override
  State<EditRichTextDocument> createState() => _EditRichTextDocumentState();
}

class _EditRichTextDocumentState extends State<EditRichTextDocument> {
  late HtmlEditorController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = HtmlEditorController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: HtmlEditor(
          controller: controller,
          htmlEditorOptions: HtmlEditorOptions(
            hint: 'Viết tin nhắn của bạn',
            spellCheck: true,
            shouldEnsureVisible: true,
            autoAdjustHeight: true,
          ),
          htmlToolbarOptions: HtmlToolbarOptions(
            toolbarPosition: ToolbarPosition.aboveEditor,
            toolbarType: ToolbarType.nativeScrollable,
            onButtonPressed:
                (ButtonType type, bool? status, Function? updateStatus) {
              return true;
            },
            onDropdownChanged: (DropdownType type, dynamic changed,
                Function(dynamic)? updateSelectedItem) {
              return true;
            },
            mediaLinkInsertInterceptor: (String url, InsertFileType type) {
              return true;
            },
            mediaUploadInterceptor:
                (PlatformFile file, InsertFileType type) async {
              return true;
            },
          ),
          otherOptions: OtherOptions(height: 900),
          callbacks: Callbacks(
              onBeforeCommand: (String? currentHtml) {},
              onChangeContent: (String? changed) {},
              onChangeCodeview: (String? changed) {},
              onChangeSelection: (EditorSettings settings) {},
              onDialogShown: () {},
              onEnter: () {},
              onFocus: () {},
              onBlur: () {},
              onBlurCodeview: () {},
              onInit: () {
                controller.setFullScreen();
              },
              onKeyDown: (int? keyCode) {},
              onKeyUp: (int? keyCode) {},
              onMouseDown: () {},
              onMouseUp: () {},
              onNavigationRequestMobile: (String url) {
                return NavigationActionPolicy.ALLOW;
              },
              onPaste: () {},
              onScroll: () {})),
    );
  }
}

class ViewRichTextDocument extends StatelessWidget {
  const ViewRichTextDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
