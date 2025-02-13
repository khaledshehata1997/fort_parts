import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());

  Future<void> refresh() async {}
  Future<void> fetchCertificates() async {
    try {
      emit(FetchCertificatesState(stateStatus: StateStatus.loading));
      final List<Certificate> certificates = await sl<IOrderRepository>().fetchCertificates();

      emit(FetchCertificatesState(
        stateStatus: StateStatus.success,
        certificates: certificates,
      ));
    } catch (e) {
      emit(FetchCertificatesState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchCertificate({
    required int certificateID,
  }) async {
    try {
      emit(FetchCertificateState(stateStatus: StateStatus.loading));
      final Certificate certificate = await sl<IOrderRepository>().fetchCertificate(certificateID: certificateID);

      emit(FetchCertificateState(
        stateStatus: StateStatus.success,
        certificate: certificate,
      ));
    } catch (e) {
      emit(FetchCertificateState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchOrders({
    required int currentPageIndex,
  }) async {
    try {
      final previousState = state;
      if (previousState is FetchOrdersState) {
        //in case of pagination
        emit(FetchOrdersState(
          stateStatus: StateStatus.success,
          orders: previousState.orders,
        ));
      } else {
        //in case of first call
        emit(FetchOrdersState(stateStatus: StateStatus.loading));
      }

      final Orders orders = await sl<IOrderRepository>().fetchOrders(
        currentPageIndex: currentPageIndex,
      );

      final Meta meta = Meta(
        currentPage: orders.current,
        totalPages: orders.total,
      );
      final List<Order> ordersList = [];

      //in case of pagination
      if (previousState is FetchOrdersState) {
        ordersList.addAll(previousState.orders);
      }

      ordersList.addAll(orders.orders);

      emit(FetchOrdersState(
        stateStatus: StateStatus.success,
        orders: ordersList,
        meta: meta,
      ));
    } catch (e) {
      emit(FetchOrdersState(stateStatus: StateStatus.error));
      rethrow;
    }
  }

  Future<void> fetchOrder({
    required int orderID,
  }) async {
    try {
      emit(FetchOrderState(stateStatus: StateStatus.loading));
      final Order order = await sl<IOrderRepository>().fetchOrder(orderID: orderID);

      emit(FetchOrderState(
        stateStatus: StateStatus.success,
        order: order,
      ));
    } catch (e) {
      emit(FetchOrderState(stateStatus: StateStatus.error));
      rethrow;
    }
  }
}
