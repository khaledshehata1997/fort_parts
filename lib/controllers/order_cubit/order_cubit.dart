import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/order_cubit/order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialState());

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
}
