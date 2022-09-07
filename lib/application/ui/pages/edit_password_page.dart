import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:password_manager/application/bloc/current_password_bloc/current_password_bloc.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';
import 'package:password_manager/domain/entities/password_metadata.dart';
import 'package:password_manager/domain/repositories/input_validators.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';

class EditNewPasswordPage extends StatelessWidget {
  const EditNewPasswordPage({
    Key? key,
    required PasswordMetadata metadata,
  })  : _metadata = metadata,
        super(key: key);
  final PasswordMetadata _metadata;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add a new password'),
        ),
        body: _EditPasswordPage(metadata: _metadata),
      ),
    );
  }
}

class _EditPasswordPage extends StatefulWidget {
  const _EditPasswordPage({
    Key? key,
    required this.metadata,
  }) : super(key: key);
  final PasswordMetadata metadata;

  @override
  State<_EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<_EditPasswordPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _userController;
  late final TextEditingController _passwordController;
  late final TextEditingController _urlController;
  late final TextEditingController _notesController;
  bool _obscurePassword = true;

  @override
  void initState() {
    BlocProvider.of<CurrentPasswordBloc>(context)
        .add(PasswordRead(path: widget.metadata.id));
    _nameController = TextEditingController(text: widget.metadata.name);
    _userController = TextEditingController(text: widget.metadata.username);
    _passwordController = TextEditingController(text: '');
    _urlController = TextEditingController(text: widget.metadata.url);
    _notesController = TextEditingController(text: widget.metadata.notes);
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentPasswordBloc, CurrentPasswordState>(
      listener: (context, state) {
        state.failureOption.fold(
          () {
            _passwordController.text = state.password;
          },
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.msg),
              ),
            );
          },
        );
        if (state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8, top: 16, left: 8, right: 8),
                  child: TextFormField(
                    controller: _nameController,
                    validator: nonEmptyValidator,
                    decoration: InputDecoration(
                      label: const Text('Name'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _userController,
                    validator: nonEmptyValidator,
                    decoration: InputDecoration(
                      label: const Text('Username'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: nonEmptyValidator,
                    obscureText: _obscurePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                        icon: const Icon(Icons.remove_red_eye),
                      ),
                      label: const Text('Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      label: const Text('Url'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    maxLines: 8,
                    controller: _notesController,
                    decoration: InputDecoration(
                      label: const Text('Notes'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GFButton(
                    text: 'Save',
                    color: Theme.of(context).primaryColor,
                    textStyle: const TextStyle(fontSize: 20),
                    shape: GFButtonShape.standard,
                    fullWidthButton: true,
                    onPressed: () {
                      if (_key.currentState != null &&
                          _key.currentState!.validate()) {
                        final passwordMetadataValue = PasswordMetadataValue(
                          name: _nameController.text,
                          username: _userController.text,
                          url: _urlController.text,
                          notes: _notesController.text,
                        );
                        context.read<PasswordListBloc>().add(PasswordAdded(
                              passwordValue: _passwordController.text,
                              metadataValue: passwordMetadataValue,
                            ));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
