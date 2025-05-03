enum TransactionStatus {
  all(simpleName: 'All'),
  successful(simpleName: 'Successfull'),
  pending(simpleName: 'Pending'),
  failed(simpleName: 'Failed');

  const TransactionStatus({required this.simpleName});
  final String simpleName;
}
