import 'package:dashboard_fruit_hub/core/utils/constants.dart';
import 'package:dashboard_fruit_hub/features/add_product/presentation/views/widgets/add_product_form.dart';
import 'package:flutter/material.dart';

class AddProductViewBody extends StatelessWidget {
  const AddProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            children: [
              SizedBox(height: kTopPadding),
              AddProductForm(),
            ],
          ),
        ),
      ),
    );
  }
}
