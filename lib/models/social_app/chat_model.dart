class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String text;
  String imageOfSender =
      "https://cdn-icons-png.flaticon.com/512/2040/2040946.png";

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    imageOfSender = json['imageOfSender'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'imageOfSender': imageOfSender,
    };
  }
}
