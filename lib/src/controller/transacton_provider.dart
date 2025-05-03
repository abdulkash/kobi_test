import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kobi_test/src/model/enum/status.dart';
import 'package:kobi_test/src/model/transaction_model.dart';

final transactionFilter = StateProvider<TransactionFilters>((ref) => (time: null, status: null));

final transactionProviders = StateProvider<List<TransactionModel>>((ref) {
  final filters = ref.watch(transactionFilter);

  return getData(status: filters.status);
});
