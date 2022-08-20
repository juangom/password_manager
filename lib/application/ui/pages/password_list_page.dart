import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';

class PasswordListPage extends StatelessWidget {
  const PasswordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordListBloc, PasswordListBlocState>(
      builder: (context, state) {
        if (state.metadataList.isEmpty) {
          return Center();
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            final password = state.metadataList[index];
            return ListTile(title: Text(password.name));
          },
        );
      },
    );
  }
}
