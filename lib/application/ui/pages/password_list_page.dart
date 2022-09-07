import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/application/bloc/current_password_bloc/current_password_bloc.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';
import 'package:password_manager/application/ui/widgets/dialogs/delete_password.dart';

class PasswordListPage extends StatelessWidget {
  const PasswordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordListBloc, PasswordListBlocState>(
      builder: (context, state) {
        if (state.metadataList.isEmpty) {
          return const Center(
            child: Text("You don't have items"),
          );
        }
        return ListView.builder(
          itemCount: state.metadataList.length,
          itemBuilder: (context, index) {
            final metadata = state.metadataList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),

                // DELETE
                leading: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deletePasswordDialog(context, metadata.id, index);
                  },
                ),
                title: Text(metadata.name),
                subtitle: Text(
                  metadata.url ?? '',
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context
                        .read<CurrentPasswordBloc>()
                        .add(PasswordRead(path: metadata.id));
                    Navigator.of(context).pushNamed('edit_password', arguments: metadata);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
