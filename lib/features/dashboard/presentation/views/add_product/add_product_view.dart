import 'package:flutter/material.dart';

import '../../../../../core/helpers/confirm_exit_dialog.dart';
import '../../../../../core/shared/widgets/app_text_widget.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import 'widgets/add_product_view_body.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});
  static const routeName = 'add-product';

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  Future<void> _onExit() async {
    final shouldExit = await showConfirmExitDialog(context);
    if (shouldExit && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onExit();
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: const AddProductViewBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,

      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: AppColors.grayscale800,
        ),
        onPressed: _onExit,
      ),
      title: AppTextWidget(
        'إضافة منتج جديد',
        style: AppTextStyles.styleBold16.copyWith(
          color: AppColors.grayscale900,
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: _onExit,
          child: AppTextWidget(
            'إلغاء',
            style: AppTextStyles.styleBold13.copyWith(
              color: AppColors.secondaryDark,
            ),
          ),
        ),
      ],
    );
  }
}
