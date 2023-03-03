import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';
import 'package:wellfare_party_app/models/messageModel.dart';
import 'package:wellfare_party_app/utils/snackbar_utils.dart';

class SingleMessageScreen extends StatefulWidget {
  static const String id = "singleMessagescreen";
  MessageModel message;
  SingleMessageScreen({required this.message, super.key});

  @override
  State<SingleMessageScreen> createState() => _SingleMessageScreenState();
}

class _SingleMessageScreenState extends State<SingleMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Message",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(widget.message.createdAt.toString().split(" ")[0]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.message.subject,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  widget.message.message,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(
                    Uri.parse(
                        "$baseUrl/uploads/message_attachments/${widget.message.attachment}"),
                    mode: LaunchMode.externalApplication,
                  )) {
                    showSnackbar(
                      context: context,
                      text: "Failed",
                    );
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffEEEEEE),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          maxLines: 1,
                          widget.message.attachment.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
