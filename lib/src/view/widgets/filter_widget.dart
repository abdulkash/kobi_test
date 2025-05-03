import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobi_test/core/utils/colors.dart';
import 'package:kobi_test/core/utils/theme.dart';
import 'package:kobi_test/src/controller/transacton_provider.dart';
import 'package:kobi_test/src/model/enum/status.dart';
import 'package:kobi_test/src/view/widgets/bottom_sheet_widget.dart';

Future<void> showFilterModal(BuildContext context) => showModalBottomSheet(
      context: context,
      builder: (_) => const TransactionFilterWidget(),
    );

class TransactionFilterWidget extends ConsumerStatefulWidget {
  const TransactionFilterWidget({super.key});

  @override
  ConsumerState<TransactionFilterWidget> createState() => _RideHistoryFilterWidgetState();
}

class _RideHistoryFilterWidgetState extends ConsumerState<TransactionFilterWidget> {
  final status = TransactionStatus.values;

  late TransactionStatus? selectedStatus = ref.read(transactionFilter).status;

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Filter",
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Status',
              style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            3.verticalSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...status.map((x) {
                    // if (x == RideOptionEnum.CARHIRE.simpleName) return Container();
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          selectedStatus = x;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.grey800,
                          border: x == selectedStatus
                              ? Border.all(
                                  color: AppColors.primary,
                                  width: 0.8,
                                )
                              : null,
                        ),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        child: Text(x.simpleName),
                      ),
                    );
                  }),
                ],
              ),
            ),
            25.verticalSpace,
            Consumer(builder: (context, ref, _) {
              return ElevatedButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    ref.read(transactionFilter.notifier).state = (
                      time: null,
                      status: selectedStatus,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Apply"));
            })
          ],
        ),
      );
    });
  }
}
