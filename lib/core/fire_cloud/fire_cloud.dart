
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/chat/data/model/messages_model.dart';
import '../constant/constant.dart';

class FireCloud {
  static Future<void> sendMessage(MessageModel message ) async {
    CollectionReference messages =
        FirebaseFirestore.instance.collection("messages");
    await messages.add(message.toJson());
  }

  static Stream<QuerySnapshot<Object?>> getMessages() {
    CollectionReference messages =
        FirebaseFirestore.instance.collection(kMessageCollection);
    return messages.orderBy('time', descending: true).snapshots();
  }
}
// message.orderBy('time', descending: true).snapshots(),