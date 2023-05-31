import 'package:flutter/material.dart';
import 'package:med_express/services/show_services.dart' as show;
import 'package:med_express/services/user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings_remote_sharp),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: () {
                  
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Clear search history'),
              onTap: () {
                User.current.clearHistory().then((_) {
                  show.successSnackBar(context,
                      message: 'History cleared successfully!');
                });
              },
            )
          ],
        ));
  }
}
