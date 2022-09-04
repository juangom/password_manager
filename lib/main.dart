import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/application/bloc/current_password_bloc/current_password_bloc.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';
import 'package:password_manager/application/ui/pages/home_page.dart';
import 'package:password_manager/core/inject.dart';
import 'package:password_manager/core/routes.dart';
import 'package:password_manager/core/theme.dart';
import 'package:password_manager/domain/repositories/copy_repository.dart';
import 'package:password_manager/domain/repositories/password_repository.dart';
import 'package:password_manager/domain/repositories/storage_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(Environment.dev);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PasswordListBloc(
            repository: getIt<PasswordListRepository>(),
            storageRepository: getIt<StorageRepository>(),
          )..add(PasswordListLoaded()),
        ),
        BlocProvider(
          create: (_) => CurrentPasswordBloc(
            storageRepository: getIt<StorageRepository>(),
            copyRepository: getIt<CopyRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        theme: theme,
        home: const HomePage(),
      ),
    );
  }
}
