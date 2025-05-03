import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobi_test/core/utils/colors.dart';
import 'package:kobi_test/core/utils/theme.dart';
import 'package:uicons/uicons.dart';

/// [BottomSheetWidget] that this is the parent widget for the [BottomSheetComponent] that houses the [BottomSheetItem]
/// and the [customChild] takes in [style] argument of [VBottomSheetStyle].
class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
    required this.builder,
    this.title,
    this.showCloseIcon = false,
    this.showDrag = true,
    this.hasSafeArea = true,
    this.onClose,
  });

  /// takes in cutom widget for non-action based widgets
  final Widget Function(BuildContext) builder;

  ///nullable [title] for bottom sheet
  final String? title;

  /// Boolean flag to show close icon on [BottomSheetWidget]
  final bool showCloseIcon;

  /// Callback for when close icon is tapped to pop the modal
  final VoidCallback? onClose;

  /// disables or enables the drag handle
  final bool showDrag;

  final bool hasSafeArea;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: const ElasticInOutCurve(1.8), // Curves.elasticOut,
  );

  @override
  void initState() {
    HapticFeedback.lightImpact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        // scale: _animation,
        // alignment: Alignment.center,
        sizeFactor: _animation,
        axisAlignment: -5.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.black, // context.theme.bottomSheetTheme.backgroundColor ?? widget.style?.backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: SafeArea(
            top: false,
            bottom: widget.hasSafeArea,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                if (widget.showDrag) ...[
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
                8.verticalSpace,
                Row(
                  children: [
                    if (widget.title != null) ...[
                      const Spacer(),
                      // 25.horizontalSpace,
                      Text(
                        widget.title!,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (widget.showCloseIcon)
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onClose?.call();
                        },
                        child: Icon(
                          UIcons.boldRounded.cross_small,
                          color: context.theme.primaryColor,
                        ),
                      )
                  ],
                ),
                10.verticalSpace,

                widget.builder(context),
                // 10.verticalSpace,
              ],
            ),
          ),
        ));
  }
}
