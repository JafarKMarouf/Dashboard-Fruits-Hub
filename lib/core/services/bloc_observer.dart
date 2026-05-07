import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('Bloc:${bloc.runtimeType}, change: $change');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('Bloc: ${bloc.runtimeType}, create: $bloc');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    log('Bloc: ${bloc.runtimeType}, transition: $bloc');
  }
}
