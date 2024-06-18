import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nantes'),
        titleTextStyle: const TextStyle(
          fontSize: 29.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'InknutAntiqua',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_on, color: Colors.white),
            onPressed: () {
              print('location');
            },
          ),
        ],
        backgroundColor: const Color(0xFF12112D),
      ),
      backgroundColor: const Color(0xFF12112D),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                IconWithText(
                  icon: Icons.event,
                  text: 'Ce soir',
                  fontFamily: 'VotrePolice',
                  backgroundColor: Color(0x28C8C8C8),
                ),
                SizedBox(width: 20),
                IconWithText(
                  icon: Icons.new_releases,
                  text: 'Nouveauté',
                  fontFamily: 'VotrePolice',
                  backgroundColor: Color(0x28C8C8C8),
                ),
                SizedBox(width: 20),
                IconWithText(
                  icon: Icons.festival,
                  text: 'Festival',
                  fontFamily: 'VotrePolice',
                  backgroundColor: Color(0x28C8C8C8),
                ),
                SizedBox(width: 20),
                IconWithText(
                  icon: Icons.favorite,
                  text: 'Favoris',
                  fontFamily: 'VotrePolice',
                  backgroundColor: Color(0x28C8C8C8),
                ),
                SizedBox(width: 20),
                IconWithText(
                  icon: Icons.local_library,
                  text: 'Culture',
                  fontFamily: 'VotrePolice',
                  backgroundColor: Color(0x28C8C8C8),
                ),
                SizedBox(width: 20),
                IconWithText(
                  icon: Icons.menu,
                  text: 'Autre',
                  fontFamily: 'VotrePolice',
                  backgroundColor: Color(0x28C8C8C8),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: EventListView(),
          ),
        ],
      ),
    );
  }
}

class EventListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('event').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Une erreur est survenue'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Pas d\'événements disponibles'));
        }

        List<DocumentSnapshot> events = snapshot.data!.docs;

        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index].data() as Map<String, dynamic>;
            final imageUrl = event['imageUrl'] ?? '';
            final style = event['style'] ?? '';
            final title = event['title'] ?? '';
            final date = event['date'] ?? '';
            final location = event['location'] ?? '';

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    style,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    location,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            );
          },
        );
      },
    );
  }
}


class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;
  final String fontFamily;
  final Color backgroundColor;

  const IconWithText({
    Key? key,
    required this.icon,
    required this.text,
    required this.fontFamily,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

