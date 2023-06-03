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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.computer),
          title: const Text('Site Preferences'),
          trailing: PopupMenuButton(
            color: Theme.of(context).primaryColor,
            onSelected: (site) {
              if (User.current.sitePreferences.contains(site)) {
                User.current.sitePreferences.remove(site);
              } else {
                User.current.sitePreferences.add(site);
              }

              User.current
                  .updateUser(sitePreferences: User.current.sitePreferences);
            },
            itemBuilder: (context) {
              return SearchService.validSites.map((site) {
                return CheckedPopupMenuItem(
                  value: site,
                  checked: User.current.sitePreferences.contains(site),
                  child: Text(site),
                );
              }).toList();
            },
          ),
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
