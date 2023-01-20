import 'package:chat_messenger/constants/data.dart';
import 'package:chat_messenger/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String avatarUrl;
  final bool isOnline;
  final bool isStory;
  const CustomCircleAvatar({Key? key, required this.avatarUrl, required this.isOnline, required this.isStory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: Stack(
        children: <Widget>[
          isOnline ?
          Container(
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: blue_story, width: 3)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(avatarUrl),
                        fit: BoxFit.cover)),
              ),
            ),
          )
          : Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(avatarUrl),
                      fit: BoxFit.cover)),
          ),
          isOnline ?
          Positioned(
            top: 48,
            left: 52,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: online,
                  shape: BoxShape.circle,
                  border: Border.all(color: white, width: 3)),
            ),
          )
          : Container()
        ],
      ),
    );
  }
}
