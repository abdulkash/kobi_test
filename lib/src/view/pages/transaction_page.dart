import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:kobi_test/core/utils/colors.dart';
import 'package:kobi_test/core/utils/currency_formatter.dart';
import 'package:kobi_test/core/utils/theme.dart';
import 'package:kobi_test/src/controller/transacton_provider.dart';
import 'package:kobi_test/src/view/widgets/filter_widget.dart';
import 'package:uicons/uicons.dart';

class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionProviders);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Transaction Activity'),
        actions: [
          GestureDetector(
            onTap: () => showFilterModal(context),
            //   context: context,
            //   child: const PaymentHistoryFilterWidget(),
            // ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.grey800,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    UIcons.boldRounded.filter,
                    color: AppColors.grey300,
                    size: 18,
                  ),
                  5.horizontalSpace,
                  Text(
                    'Filter',
                    style: context.textTheme.labelLarge?.copyWith(color: AppColors.grey300, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          8.horizontalSpace,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Builder(builder: (context) {
          if (transactions.isEmpty) {
            return Center(
              child: Text(
                'You haven`t made any transaction yet. Check back later.',
                textAlign: TextAlign.center,
                style: context.textTheme.labelLarge?.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            );
          }

          return ListView.separated(
            // shrinkWrap: true,
            itemBuilder: (_, index) {
              final item = transactions[index];

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 600),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: AppColors.grey700,
                          child: Icon(
                            UIcons.solidRounded.money,
                            color: AppColors.grey400,
                          ),
                        ),
                        8.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: context.textTheme.bodyLarge,
                            ),
                            Text(
                              DateFormat().format(item.createdAt),
                              style: context.textTheme.labelMedium?.copyWith(color: AppColors.grey500, height: 0),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          item.amount.formatToNaira,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => 15.verticalSpace,
            itemCount: transactions.length,
          );
        }),
      ),
    );
  }
}
