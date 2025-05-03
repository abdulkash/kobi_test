import 'package:kobi_test/src/model/enum/status.dart';

typedef TransactionModel = ({
  String title,
  DateTime createdAt,
  String amount,
  TransactionStatus status,
});

typedef TransactionFilters = ({
  DateTime? time,
  TransactionStatus? status,
});

List<TransactionModel> getData({TransactionStatus? status}) {
  final data = <TransactionModel>[
    (
      title: 'Account Funding',
      createdAt: DateTime.now(),
      amount: '10000',
      status: TransactionStatus.successful,
    ),
    (
      title: 'VAT service',
      createdAt: DateTime.now(),
      amount: '10000',
      status: TransactionStatus.successful,
    ),
    (
      title: 'Withdrawal',
      createdAt: DateTime.now(),
      amount: '1800',
      status: TransactionStatus.failed,
    ),
    (
      title: 'Transfer',
      createdAt: DateTime.now(),
      amount: '1000',
      status: TransactionStatus.failed,
    ),
  ];

  return switch (status) {
    // TransactionStatus.all => data,
    TransactionStatus.successful => data.where((e) => e.status == TransactionStatus.successful).toList(),
    TransactionStatus.pending => data.where((e) => e.status == TransactionStatus.pending).toList(),
    TransactionStatus.failed => data.where((e) => e.status == TransactionStatus.failed).toList(),
    _ => data
  };
}
