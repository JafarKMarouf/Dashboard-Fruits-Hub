import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/build_messages_bar.dart';
import '../../../../../core/l10n/l10n.dart';
import '../../../../../core/shared/widgets/bottom_nav_bar/app_shell.dart';
import '../../../../../core/shared/widgets/custom_progress_hud.dart';
import '../../cubits/signin_cubit/signin_cubit.dart';
import 'signin_view_body.dart';

class SigninViewBlocConsumer extends StatelessWidget {
  const SigninViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninFailure) {
          final locale = AppLocalizations.of(context);
          final localizedMessage = switch (state.message) {
            'invalidEmail' => locale.invalidEmail,
            'invalidCredential' => locale.invalidCredential,
            'networkRequestFailed' => locale.networkRequestFailed,
            'notAuthorized' => locale.notAuthorized,
            _ => locale.genericError,
          };
          buildErrorBar(context, localizedMessage);
        }
        if (state is SigninSuccess) {
          buildSuccessMessage(
            context,
            AppLocalizations.of(context).loginSuccess,
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppShell.routeName,
              (route) => false,
            );
          });
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading,
          child: const Scaffold(
            backgroundColor: Color(0xFFF4F5F7),
            body: SigninViewBody(),
          ),
        );
      },
    );
  }
}
