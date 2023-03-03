import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:wellfare_party_app/MainConst/main_const.dart';
import 'package:wellfare_party_app/Screens/messages/AllMessages/singleMessageView.dart';
import 'package:wellfare_party_app/commonComponents/wave_loader.dart';
import 'package:wellfare_party_app/models/messageModel.dart';
import 'package:wellfare_party_app/providers/messageProvider.dart';

import 'components/singleMessageCard.dart';

class AllMessagesScreen extends StatefulWidget {
  static const String id = "allmessages";
  const AllMessagesScreen({super.key});

  @override
  State<AllMessagesScreen> createState() => _AllMessagesScreenState();
}

class _AllMessagesScreenState extends State<AllMessagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getInitialDetails());
  }

  _getInitialDetails() async {
    var messagePov = Provider.of<MessageProvider>(context, listen: false);
    messagePov.getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Messages",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<MessageProvider>(
          builder: (context, messageProvider, child) => Stack(
            children: [
              Column(
                children: [
                  if (messageProvider.messageList.isEmpty)
                    const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No messages"),
                    )),
                  for (MessageModel messege in messageProvider.messageList)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => SingleMessageScreen(
                              message: messege,
                            ),
                          ),
                        );
                      },
                      child: SingleMessageCard(message: messege),
                    ),
                ],
              ),
              if (messageProvider.loading == true) WaveLoader()
            ],
          ),
        ),
      ),
    );
  }
}
