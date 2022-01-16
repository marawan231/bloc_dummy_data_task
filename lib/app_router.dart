import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubit/owners_cubit.dart';

import 'data/repoistry/owners_repoistry.dart';
import 'data/web_services/owners_web_services.dart';

import 'constants/strings.dart';

import 'presentation/screens/owners_screen.dart';

class AppRouter {
  late OwnersRepoistry ownersRepoistry;

  late OwnersCubit ownersCubit;

  AppRouter() {
    ownersRepoistry = OwnersRepoistry(OwnersWebServices());
    ownersCubit = OwnersCubit(ownersRepoistry);
  }
  Route? genertaRoute(RouteSettings settings) {
    switch (settings.name) {
      case ownersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ownersCubit,
            child: const OwnersScreen(),
          ),
        );
    }
  }
}
