import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/shared/widgets/app_primary_button.dart';
import '../../../../../core/shared/widgets/app_text_form_field.dart';
import '../../../../../core/shared/widgets/app_text_widget.dart';
import '../../../domain/requests/user_request.dart';
import '../../cubits/signin_cubit/signin_cubit.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email, password;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late bool _showFieldShadows = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          const SizedBox(height: 16),
          AppTextFormField(
            hintText: 'admin@fruithub.com',
            textInputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            showShadow: _showFieldShadows,
            onSaved: (value) => email = value!,
            label: AppLocalizations.of(context).emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(height: 16),
          AppTextFormField(
            hintText: '********',
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            showShadow: _showFieldShadows,
            onSaved: (value) => password = value!,
            label: AppLocalizations.of(context).password,
            obscureText: true,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: AppTextWidget(
                  AppLocalizations.of(context).forgetPassword,
                  style: AppTextStyles.styleBold13.copyWith(
                    color: AppColors.green1_500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppPrimaryButton(
            text: AppLocalizations.of(context).login,
            onPressed: _onSubmit,
          ),
          const SizedBox(height: 33),
        ],
      ),
    );
  }

  void _onSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<SigninCubit>().signin(
        request: UserRequest(email: email, password: password),
      );
    } else {
      setState(() {
        autoValidateMode = AutovalidateMode.always;
        _showFieldShadows = false;
      });
    }
  }
}
