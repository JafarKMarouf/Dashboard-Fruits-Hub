import 'package:dashboard_fruit_hub/core/utils/shared/widgets/custom_progress_hud.dart';
import 'package:dashboard_fruit_hub/features/add_product/presentation/manage/add_product_cubit/add_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/helpers/build_messages_bar.dart';
import '../../../../../core/utils/helpers/confirm_exit_dialog.dart';
import '../../../../../core/utils/shared/widgets/app_text_widget.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import 'add_product_view_body.dart';

class AddProductBlocConsumer extends StatefulWidget {
  const AddProductBlocConsumer({super.key});

  @override
  State<AddProductBlocConsumer> createState() => _AddProductBlocConsumerState();
}

class _AddProductBlocConsumerState extends State<AddProductBlocConsumer> {
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
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) await _onExit();
      },
      child: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is AddProductFailure) {
            showErrorBar(context, state.message);
          }
          if (state is AddProductSuccess) {
            buildSuccessMessage(context, 'تمت إضافة المنتج بنجاح.');
            Future.delayed(const Duration(milliseconds: 400), () {
              Navigator.of(context).pop();
            });
          }
        },
        builder: (context, state) {
          return CustomProgressHud(
            isLoading: state is AddProductLoading,
            child: Scaffold(
              appBar: _buildAppBar(context),
              body: const AddProductViewBody(),
            ),
          );
        },
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
            style: AppTextStyles.styleBold14.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ),
      ],
    );
  }
}
