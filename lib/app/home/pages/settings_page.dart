import 'package:flutter/material.dart';
import 'package:med_express/services/search_service.dart';
import 'package:med_express/services/show_services.dart' as show;
import 'package:med_express/services/user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isExpansionPanelOpen = false;
  late final List<bool> _isChecked =
      List<bool>.filled(SearchService.validSites.length, false);

  @override
  Widget build(BuildContext context) {
    int index = -1;

    return ListView(
      children: [
        ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 300),
          elevation: 8.0,
          children: [
            ExpansionPanel(
              isExpanded: _isExpansionPanelOpen,
              headerBuilder: (_, __) => const Text('Site Preferences'),
              canTapOnHeader: true,
              body: ListView(
                children: SearchService.validSites.map((site) {
                  ++index;
                  return CheckboxListTile(
                    title: Text(site),
                    value: _isChecked[index],
                    onChanged: (value) {
                      setState(() {
                        _isChecked[index] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ],
          expansionCallback: (i, isOpen) {
            setState(() {
              _isExpansionPanelOpen = !_isExpansionPanelOpen;
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Clear search history'),
          onTap: () {
            show
                .confirmationDialog(context,
                    message: 'Are you sure you want to clear history?')
                .then((confirm) {
              if (confirm) {
                User.current.clearHistory().then((_) {
                  show.successSnackBar(
                    context,
                    message: 'History cleared successfully!',
                  );
                });
              }
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Logout'),
          trailing: const Icon(Icons.logout),
          onTap: () {
            show
                .confirmationDialog(context,
                    message: 'Are you sure you want to logout?')
                .then((confirm) {
              if (confirm) {
                User.current.logOut(context);
              }
            });
          },
        ),
        const SizedBox(height: 100.0),
        ListTile(
          textColor: Colors.red,
          leading: const Icon(Icons.warning),
          title: const Text('Delete Account'),
          onTap: () {
            show
                .confirmationDialog(context,
                    message:
                        'Are you sure you want to delete account with username: ${User.current.username}')
                .then((confirm) {
              if (confirm) {
                User.current.deleteUser(context);
              }
            });
          },
        )
      ],
    );
  }
}
