class Orders {
  Orders({
    required this.orders,
    required this.total,
    required this.current,
  });

  final List<Order> orders;
  final int total;
  final int current;

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      orders: List<Order>.from(json['items'].map((x) => Order.fromJson(x))),
      total: json['last_page'],
      current: json['current'],
    );
  }
}

class Order {
  Order({
    required this.id,
    required this.tasksCount,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  final int id;
  final int tasksCount;
  final String date;
  final String status;
  final String statusColor;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      tasksCount: json['count_task'],
      date: json['data'],
      status: json['status'],
      statusColor: json['color_status'],
    );
  }
}
