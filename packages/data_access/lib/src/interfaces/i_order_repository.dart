import 'package:data_access/src/models/certificate.dart';

abstract class IOrderRepository {
  Future<List<Certificate>> fetchCertificates();

  Future<Certificate> fetchCertificate({
    required int certificateID,
  });
}
