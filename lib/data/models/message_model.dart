class MessageModel {
  String? message, email;
  // ignore: prefer_typing_uninitialized_variables
  var date;
  MessageModel({this.date, this.email, this.message});
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
        date: jsonData['date'],
        email: jsonData['email'],
        message: jsonData['Message']);
  }
}
