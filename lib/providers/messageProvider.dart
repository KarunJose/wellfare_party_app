import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellfare_party_app/MainConst/api_const.dart';
import 'package:wellfare_party_app/api/message_api.dart';
import 'package:wellfare_party_app/models/messageModel.dart';

class MessageProvider extends ChangeNotifier {
  bool loading = false;

  List<MessageModel> messageList = [];

  toggleloading(bool load) {
    loading = load;
    notifyListeners();
  }

  sendMessage({
    String? recipientId,
    String? subject,
    String? message,
    String? stateId,
    String? districtId,
    String? constituencyId,
    String? panchayathId,
    String? unitId,
    String? attachmentName,
    String? attachmentData,
  }) async {
    toggleloading(true);

    //Api req

    await sendMessageAPI(
      recipientId: recipientId,
      subject: subject,
      message: message,
      stateId: stateId,
      districtId: districtId,
      constituencyId: constituencyId,
      panchayathId: panchayathId,
      unitId: unitId,
      attachmentName: attachmentName,
      attachmentData: attachmentData,
    );
    toggleloading(false);
  }

  getMessage({
    String? title,
    String? message,
    String? attachment,
    String? date,
  }) async {
    toggleloading(true);

    var response = await getMessageAPI(
      title: title,
      message: message,
      attachment: attachment,
      date: date,
    );
    var responseJson = response.data;
    for (var message in responseJson["messages"]) {
      messageList.add(MessageModel.fromJson(message));
    }
    toggleloading(false);
  }

  deleteMessage({
    String? messageId,
  }) async {
    toggleloading(true);
    var response = await deleteMessageAPI(
      messageId: messageId,
    );
    var responseJson = response.data;
  }
}
