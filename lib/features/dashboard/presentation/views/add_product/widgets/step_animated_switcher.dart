import 'package:flutter/material.dart';

class StepAnimatedSwitcher extends StatelessWidget {
  const StepAnimatedSwitcher({
    super.key,
    required this.currentStep,
    required this.forward,
    required this.child,
  });

  final int currentStep;
  final bool forward;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: _transitionBuilder,
      child: KeyedSubtree(key: ValueKey(currentStep), child: child),
    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final isIncoming = child.key == ValueKey(currentStep);

    final beginOffset = isIncoming
        ? (forward ? const Offset(-1.0, 0) : const Offset(1.0, 0))
        : (forward ? const Offset(1.0, 0) : const Offset(-1.0, 0));

    final offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(animation);

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}
