class NotificationModel {
  String senderPhotoUrl;
  String senderName;
  String senderType;
  String messageType;
  String messagePhotoUrl;
  String time;
  String description;
  String address;
  String activityTime;

  NotificationModel({
    required this.senderPhotoUrl,
    required this.senderName,
    required this.senderType,
    required this.messageType,
    required this.messagePhotoUrl,
    required this.time,
    required this.description,
    required this.address,
    required this.activityTime,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      senderPhotoUrl: json['sender_photo_url'],
      senderName: json['sender_name'],
      senderType: json['sender_type'],
      messageType: json['message_type'],
      messagePhotoUrl: json['message_photo_url'],
      time: json['time'],
      description: json['description'],
      address: json['address'],
      activityTime: json['activity_time'],
    );
  }
}
