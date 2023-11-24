// To parse this JSON data, do
//
//     final notificationCountModel = notificationCountModelFromJson(jsonString);

import 'dart:convert';

NotificationCountModel notificationCountModelFromJson(String str) => NotificationCountModel.fromJson(json.decode(str));

String notificationCountModelToJson(NotificationCountModel data) => json.encode(data.toJson());

class NotificationCountModel {
  int unreadNotificationCount;

  NotificationCountModel({
    this.unreadNotificationCount,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) => NotificationCountModel(
    unreadNotificationCount: json["unread_notification_count"],
  );

  Map<String, dynamic> toJson() => {
    "unread_notification_count": unreadNotificationCount,
  };
}
