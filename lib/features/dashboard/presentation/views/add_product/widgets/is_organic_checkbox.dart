import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../auth/presentation/views/widgets/custom_checkbox.dart';

class IsOrganicCheckbox extends StatefulWidget {
  const IsOrganicCheckbox({
    super.key,
    required this.changed,
    this.initialValue = false,
  });

  final ValueChanged<bool> changed;
  final bool initialValue;

  @override
  State<IsOrganicCheckbox> createState() => _IsOrganicCheckboxState();
}

class _IsOrganicCheckboxState extends State<IsOrganicCheckbox> {
  bool isAccepted = false;
  @override
  void initState() {
    super.initState();
    isAccepted = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        CustomCheckbox(
          isChecked: isAccepted,
          onChecked: (value) {
            setState(() {
              isAccepted = value;
              widget.changed(value);
            });
          },
        ),
        const Expanded(child: AppTextWidget('هل هذا المنتج طبيعي؟')),
      ],
    );
  }
}
