import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gp_version_01/models/ChatMessage.dart';
import 'package:gp_version_01/models/ChatUsers.dart';

class ChatController with ChangeNotifier {
  var firestoreInstance = FirebaseFirestore.instance;

  List<ChatUsers> userConversations = [];
  ChatUsers chatUser;

  Future<void> getUserChat(String userId) async {
    String currentUserIsSender =
        FirebaseAuth.instance.currentUser.uid + '_' + userId;
    List<ChatMessage> messages = [];
    String docId;
    ChatUsers temp;
    QuerySnapshot snapshot = await firestoreInstance
        .collection('Chat')
        .where("fromId_toId", isEqualTo: currentUserIsSender)
        .get();
    snapshot.docs.forEach((element) {
      temp = ChatUsers(
        lastText: element['lastText'],
        receiverId: userId,
        senderId: FirebaseAuth.instance.currentUser.uid,
        time: element['time'],
      );
      docId = element.id;
    });
    QuerySnapshot snapshot2 = await firestoreInstance
        .collection('Chat')
        .doc(docId)
        .collection('Message')
        .get();
    snapshot2.docs.forEach((element2) {
      messages.add(new ChatMessage(
          messageContent: element2['messageContent'],
          senderId: element2['fromId'],
          time: element2['time']));
    });
    temp.messages = messages;
    chatUser = temp;
    notifyListeners();
  }

  Future<void> getUserConversations() async {
    String userID = FirebaseAuth.instance.currentUser.uid;
    List<ChatMessage> messages = [];
    List<ChatUsers> tempList = [];
    ChatUsers temp;
    QuerySnapshot snapshot = await firestoreInstance.collection('Chat').get();
    snapshot.docs.forEach((element) async {
      String str = element['fromId_toId'];
      List<String> splitted = str.split('_');
      if (splitted[0] == userID || splitted[1] == userID) {
        if (splitted[0] == userID) {
          temp = ChatUsers(
            lastText: element['lastText'],
            receiverId: splitted[1],
            senderId: userID,
            time: element['time'],
          );
        }else{
          temp = ChatUsers(
            lastText: element['lastText'],
            receiverId: userID,
            senderId: splitted[0],
            time: element['time'],
          );
        }
        QuerySnapshot snapshot2 = await firestoreInstance
            .collection('Chat')
            .doc(element.id)
            .collection('Message')
            .get();
        snapshot2.docs.forEach((element2) {
          messages.add(new ChatMessage(
              messageContent: element2['messageContent'],
              senderId: element2['fromId'],
              time: element2['time']));
        });
        temp.messages = messages;
        tempList.add(temp);
      }
    }) ;
    userConversations=tempList;
    notifyListeners();
  }
}