class Notifications {
  Notifications({
    required this.notifications,
    required this.total,
    required this.current,
  });

  final List<Notification> notifications;
  final int total;
  final int current;

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      notifications: List<Notification>.from(json['items'].map((x) => Notification.fromJson(x))),
      total: json['total'],
      current: json['current'],
    );
  }
}

class Notification {
  Notification({
    required this.id,
    required this.title,
    required this.type,
    required this.typeID,
    required this.time,
  });

  final int id;
  final String title;
  final String type;
  final int typeID;
  final String time;

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      type: json['model'],
      typeID: json['model_id'],
      time: json['time'],
    );
  }
}
