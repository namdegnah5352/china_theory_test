import 'package:flutter/material.dart';
import '../calls/question_calls.dart' as calls;

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (selectedIndex) {
        setState(() {
          navDrawerIndex = selectedIndex;
          Navigator.pop(context);
          Destination.values[navDrawerIndex].function();
        });
      },
      selectedIndex: navDrawerIndex,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Mail',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ...Destination.values.map((destination) {
          return NavigationDrawerDestination(
            label: Text(destination.label),
            icon: destination.iconOutlined,
            selectedIcon: destination.icon,
          );
        }),
        const Divider(indent: 28, endIndent: 28),
      ],
    );
  }
}

enum Destination {
  search('Search', Icon(Icons.home_outlined), Icon(Icons.search), calls.loadSearchPage),
  special('Special', Icon(Icons.outbond_outlined), Icon(Icons.outbond), calls.loadSpecialPage),
  settings('Settings', Icon(Icons.inbox_outlined), Icon(Icons.inbox), calls.loadSettinsPage);

  const Destination(this.label, this.iconOutlined, this.icon, this.function);
  final String label;
  final Widget iconOutlined;
  final Widget icon;
  final Function function;
}
