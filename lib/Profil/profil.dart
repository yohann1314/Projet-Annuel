import 'package:flutter/material.dart';
import '../AddEvent/addEvent.dart';


class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Profil Page'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventPage()),
                );
              },
              child: Text('Ajouter un événement'),
            ),
          ],
        ),
      ),
    );
  }
}
