import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String? name;
  final String? image;
  const ChatScreen({
    Key? key,
    this.name,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 55,
              color: Colors.grey[600],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const BackButton(
                        color: Colors.white,
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(image!),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        name!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.video_call,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Row(children: [
        Container(
          width: 240,
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(),
            boxShadow: const [BoxShadow(color: Colors.black38)],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              icon: Icon(
                Icons.add_reaction_outlined,
                color: Theme.of(context).primaryColor,
              ),
              hintText: 'Message...',
              hintStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration:
              BoxDecoration(color: Colors.grey[600], shape: BoxShape.circle),
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }
}
