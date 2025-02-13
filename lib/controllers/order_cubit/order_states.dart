import 'package:components/components.dart';
import 'package:data_access/data_access.dart';

class OrderStates {}

class OrderInitialState extends OrderStates {}

class OrderRefreshState extends OrderStates {}

class FetchCertificatesState extends OrderStates {
  FetchCertificatesState({
    required this.stateStatus,
    this.certificates = const [],
  });
  final StateStatus stateStatus;
  final List<Certificate> certificates;
}

class FetchCertificateState extends OrderStates {
  FetchCertificateState({
    required this.stateStatus,
    this.certificate,
  });
  final StateStatus stateStatus;
  final Certificate? certificate;
}

class FetchOrdersState extends OrderStates {
  FetchOrdersState({
    required this.stateStatus,
    this.orders = const [],
    this.meta,
  });
  final StateStatus stateStatus;
  final List<Order> orders;
  final Meta? meta;
}

class FetchOrderState extends OrderStates {
  FetchOrderState({
    required this.stateStatus,
    this.order,
  });
  final StateStatus stateStatus;
  final Order? order;
}
