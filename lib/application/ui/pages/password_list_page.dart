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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (_) => _showMetadata(metadata),
                  );
                },
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  leading: IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: () {
                      if(metadata.url !=null) {
                        // TODO
                        // go to url
                      }
                    },
                  ),
                  title: Text(metadata.name),
                  subtitle: Text(''),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // show modal to confirm and show 
                    },
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
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              metadata.name,
              style: const TextStyle(fontSize: 20),
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
                  style: const TextStyle(fontSize: 20),
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
                  style: const TextStyle(
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
                  style: const TextStyle(fontSize: 20),
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
