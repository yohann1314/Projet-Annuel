import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_annuel/Carte/carte.dart';
import 'package:projet_annuel/Profil/profil.dart';
import 'package:projet_annuel/Recherche/recherche.dart';
import '../EventDetail/eventdetail.dart'; // Assurez-vous que le chemin est correct

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),  // Utiliser HomeScreen au lieu de HomePage
    RecherchePage(),
    CartePage(),
    ProfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF12112D),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Color(0xFF12112D),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Rechercher',
            backgroundColor: Color(0xFF12112D),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Carte',
            backgroundColor: Color(0xFF12112D),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Rechercher',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Carte',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profil',
        style: TextStyle(color: Colors.white),
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
            final artistId = event['artistId'] ?? ''; // Nouvelle ligne pour récupérer l'artistId
            final eventDetail = event['eventDetail'] ?? '';
            final eventProgram = event['eventProgram'] ?? '';

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailPage(
                      imageUrl: imageUrl,
                      style: style,
                      title: title,
                      date: date,
                      location: location,
                      artistId: artistId, // Passer artistId à la page de détails
                      eventDetail: eventDetail,
                      eventProgram: eventProgram,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
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
    required this.icon,
    required this.text,
    required this.fontFamily,
    required this.backgroundColor,
  });

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
