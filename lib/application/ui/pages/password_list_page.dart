import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';

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
          itemCount: state.metadataList.length,
          itemBuilder: (context, index) {
            final metadata = state.metadataList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (_) => _showMetadata(metadata),
                  );
                },
                child: ListTile(
                  subtitle: metadata.url != null
                      ? Text(metadata.url!)
                      : Container(height: 0),
                  trailing: Text(metadata.username),
                  title: Text(
                    metadata.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _showMetadata(PasswordMetadata metadata) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              metadata.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.person),
                Text(
                  metadata.username,
                  style: TextStyle(fontSize: 20),
                ),
                const Icon(Icons.copy),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  metadata.url ?? '',
                  style: TextStyle(
                    fontSize: 20,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const Icon(Icons.link)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  metadata.notes ?? '',
                  style: TextStyle(fontSize: 20),
                ),
                const Icon(Icons.note)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
