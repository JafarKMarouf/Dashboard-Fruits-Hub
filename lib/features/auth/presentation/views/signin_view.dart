import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../cubits/signin_cubit/signin_cubit.dart';
import 'widgets/signin_view_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'signin-view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SigninCubit>(),
      child: const SigninViewBlocConsumer(),
    );
  }
}
