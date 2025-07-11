import 'package:deenly/di.dart';
import 'package:deenly/features/zikr/presentation/cubits/get_zikr_cubit/get_zikr_cubit.dart';
import 'package:deenly/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/dev_tools/debug_logger.dart';

class Providers extends StatelessWidget {
  final bool isDevMode;
  const Providers({super.key, required this.isDevMode});

  @override
  Widget build(BuildContext context) {
    DebugLogger.instance.setMode(isDevMode);
    return MultiProvider(providers: [
      BlocProvider(create: (context) => locator.get<GetZikrCubit>())
    ], child: Deenly(isDevMode: isDevMode));
  }
}
