import 'package:cloud_firestore/cloud_firestore.dart';

import 'metadata_model.dart';

class MessageModel {
  final dynamic message;
  final dynamic type;
  final String id;
  final DateTime time;
  final MetadataModel? metadata;

  MessageModel({
    required this.metadata,
    required this.message,
    required this.id,
    required this.type,
    required this.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      message: jsonData["message"],
      id: jsonData['id'],
      type: jsonData['type'],
      time: (jsonData['time'] as Timestamp).toDate(),
      metadata: jsonData['metadata'] != null
          ? MetadataModel.fromJson(jsonData['metadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "type": type,
        "time": time,
        "metadata": metadata?.toJson(),
      };
}
