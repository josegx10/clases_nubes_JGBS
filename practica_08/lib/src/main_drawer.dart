import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      'data:image/png;base64,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'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 5.0),
                Text('José', style: TextStyle(fontSize: 22.0)),
                SizedBox(height: 5.0),
                Text('Alumno', style: TextStyle(fontSize: 16.0)),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: Text('Perfil'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.inbox,
            color: Colors.black,
          ),
          title: Text('Mensajeria'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.assessment,
            color: Colors.black,
          ),
          title: Text('Dasboard'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: Text('configuración'),
        )
      ],
    );
  }
}
