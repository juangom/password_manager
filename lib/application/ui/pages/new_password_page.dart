import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:password_manager/application/bloc/password_list_bloc/password_list_bloc.dart';
import 'package:password_manager/domain/repositories/input_validators.dart';
import 'package:password_manager/domain/values/password_metadata_value.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add a new password'),
        ),
        body: const _NewPasswordPage(),
      ),
    );
  }
}

class _NewPasswordPage extends StatefulWidget {
  const _NewPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  State<_NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<_NewPasswordPage> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _userController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _urlController = TextEditingController();
  late final TextEditingController _notesController = TextEditingController();
  bool _obscurePassword = true;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, top: 16, left: 8, right: 8),
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
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
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
  }
}
