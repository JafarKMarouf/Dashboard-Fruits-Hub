import '../entities/customer_entity.dart';
import '../../../../core/enums/customer_status.dart';

abstract class CustomersRepo {
  Stream<List<CustomerEntity>> watchCustomers();

  Future<void> updateCustomerStatus({
    required String customerId,
    required CustomerStatus status,
  });
}
