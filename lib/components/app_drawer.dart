import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: theme.primaryColor,
            height: 200,
          ),
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.house),
            ),
            title: Text("All Properties"),
            trailing: Icon(Icons.arrow_right_alt_rounded),
            onTap: () {
              context.push('/properties');
            },
          ),
        ],
      ),
    );
  }
}
