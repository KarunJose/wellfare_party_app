import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/Screens/messages/AllMessages/singleMessageView.dart';
import 'package:wellfare_party_app/models/messageModel.dart';
import 'package:wellfare_party_app/providers/messageProvider.dart';

class SingleMessageCard extends StatelessWidget {
  MessageModel message;
  SingleMessageCard({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
      builder: (context, messageProvider, child) => Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      message.subject,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  Text(message.createdAt.toString().split(" ")[0]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  maxLines: 2,
                  message.message,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => SingleMessageScreen(
                            message: message,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.attachment,
                            color: Colors.grey.shade500,
                          ),
                          Text(
                            "View Attachment",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await messageProvider.deleteMessage(
                        messageId: message.id,
                      );
                      messageProvider.getMessage();
                    },
                    child: Icon(
                      Icons.delete_outline_outlined,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
