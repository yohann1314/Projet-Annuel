import 'package:flutter/material.dart';
import '../EventDetail/eventdetail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
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

class Event {
  final String title;
  final String description;
  final String date;
  final String location;
  final String style;
  final String imageUrl;
  final String artistImageUrl;
  final String artistName;
  final String artistStyle;
  final String eventDetails;
  final String eventProgram;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.style,
    required this.imageUrl,
    required this.artistImageUrl,
    required this.artistName,
    required this.artistStyle,
    required this.eventDetails,
    required this.eventProgram,
  });
}

class EventListView extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: "EVENTHUB - Festival",
      description: "Description de l'événement",
      date: "Jeudi 18 Avril 2024",
      location: "10 Rue Réné Viviani 44000 Nantes",
      style: "Populaire",
      imageUrl: "https://th.bing.com/th/id/OIP.iRaLGvQGVuVVrX0kAmc9bgHaE8?rs=1&pid=ImgDetMain",
      artistImageUrl: "https://static.wixstatic.com/media/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg/v1/fill/w_1394,h_797,al_c/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg",
      artistName: "SDM",
      artistStyle: "Rap",
      eventDetails: "Festival de la Musique Éclectique 🎵\n📅 25-27 Juillet 2024\n📍 Parc des Artistes, Villeville\n🎶 Trois jours de musique live - cuisine diverse - marché artisanal - et feux d'artifice tous les soirs à 22h.\n",
      eventProgram: "Concerts live tous les soirs de 18h à minuit\nZones de restauration variées\nMarché artisanal local\nAteliers de musique et activités pour tous les âges",
    ),
    Event(
      title: "Autre événement",
      description: "Description de l'événement",
      date: "Vendredi 19 Avril 2024",
      location: "20 Rue de Strasbourg 44000 Nantes",
      style: "Festif",
      imageUrl: "https://th.bing.com/th/id/OIP.tjLiPC5O-dBOqKk7SKh8NAAAAA?rs=1&pid=ImgDetMain",
      artistImageUrl: "https://static.wixstatic.com/media/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg/v1/fill/w_1394,h_797,al_c/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg",
      artistName: "Niska",
      artistStyle: "Rap",
      eventDetails: "Détails de l'événement",
      eventProgram: "Programme de l'événement",
    ),
    Event(
      title: "Autre événement",
      description: "Description de l'événement",
      date: "Vendredi 19 Avril 2024",
      location: "20 Rue de Strasbourg 44000 Nantes",
      style: "Festif",
      imageUrl: "https://th.bing.com/th/id/OIP.tjLiPC5O-dBOqKk7SKh8NAAAAA?rs=1&pid=ImgDetMain",
      artistImageUrl: "https://static.wixstatic.com/media/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg/v1/fill/w_1394,h_797,al_c/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg",
      artistName: "Nom de l'artiste",
      artistStyle: "Style de musique",
      eventDetails: "Détails de l'événement",
      eventProgram: "Programme de l'événement",
    ),
    Event(
      title: "Autre événement",
      description: "Description de l'événement",
      date: "Vendredi 19 Avril 2024",
      location: "20 Rue de Strasbourg 44000 Nantes",
      style: "Festif",
      imageUrl: "https://th.bing.com/th/id/OIP.tjLiPC5O-dBOqKk7SKh8NAAAAA?rs=1&pid=ImgDetMain",
      artistImageUrl: "https://static.wixstatic.com/media/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg/v1/fill/w_1394,h_797,al_c/ae47ce_2c56c1bb1ad344c5a3b66bd798a76595~mv2.jpg",
      artistName: "Nom de l'artiste",
      artistStyle: "Style de musique",
      eventDetails: "Détails de l'événement",
      eventProgram: "Programme de l'événement",
    ),
    // Ajoutez autant d'événements que vous le souhaitez
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailPage(
                  imageUrl: event.imageUrl,
                  style: event.style,
                  title: event.title,
                  date: event.date,
                  location: event.location,
                  artistImageUrl: event.artistImageUrl,
                  artistName: event.artistName,
                  artistStyle: event.artistStyle,
                  eventDetails: event.eventDetails,
                  eventProgram: event.eventProgram,
                ),
              ),
            );
          },
          child: Container(
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
                    event.imageUrl,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  event.style,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  event.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  event.date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  event.location,
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
  }
}
