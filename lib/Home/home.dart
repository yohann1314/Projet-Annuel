import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

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
              height: 70, // Ajustez la hauteur selon vos besoins
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  IconWithText(
                    icon: Icons.event,
                    text: 'Ce soir',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.new_releases,
                    text: 'Nouveauté',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.festival,
                    text: 'Festival',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.favorite,
                    text: 'Favoris',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.local_library,
                    text: 'Culture',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.menu,
                    text: 'Autre',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.favorite,
                    text: 'Favoris',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.local_library,
                    text: 'Culture',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                  SizedBox(width: 20), // Espace entre les icônes
                  IconWithText(
                    icon: Icons.menu,
                    text: 'Autre',
                    fontFamily: 'VotrePolice',
                    backgroundColor: Color(0x28C8C8C8), // Couleur d'arrière-plan personnalisée
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Espace entre la liste d'icônes et le texte
            Expanded(
              child: EventListView(), // Ajout du bloc d'événements
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
        borderRadius: BorderRadius.circular(10), // Ajustez le rayon de la bordure selon vos besoins
      ),
      padding: const EdgeInsets.all(8), // Ajustez le rembourrage intérieur selon vos besoins
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 25,
          ), // Taille de l'icône ajustable selon vos besoins
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

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.style,
    required this.imageUrl,
  });
}

class EventListView extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: "Festival EVENTHUB",
      description: "Description de l'événement",
      date: "Jeudi 18 Avril 2024",
      location: "10 Rue Réné Viviani 44000 Nantes",
      style: "Populaire",
      imageUrl: "OIP.jpg", // Insérez l'URL de votre image ici
    ),
    Event(
      title: "Autre événement",
      description: "Description de l'événement",
      date: "Vendredi 19 Avril 2024",
      location: "20 Rue de Strasbourg 44000 Nantes",
      style: "Festif",
      imageUrl: "https://th.bing.com/th/id/OIP.bOYyTEu7iYJZfczpU7_81wAAAA?rs=1&pid=ImgDetMain", // Insérez l'URL de votre image ici
    ),
    Event(
      title: "Autre événement",
      description: "Description de l'événement",
      date: "Vendredi 19 Avril 2024",
      location: "20 Rue de Strasbourg 44000 Nantes",
      style: "Festif",
      imageUrl: "https://th.bing.com/th/id/OIP.bOYyTEu7iYJZfczpU7_81wAAAA?rs=1&pid=ImgDetMain", // Insérez l'URL de votre image ici
    ),
    Event(
      title: "Autre événement",
      description: "Description de l'événement",
      date: "Vendredi 19 Avril 2024",
      location: "20 Rue de Strasbourg 44000 Nantes",
      style: "Festif",
      imageUrl: "https://th.bing.com/th/id/OIP.bOYyTEu7iYJZfczpU7_81wAAAA?rs=1&pid=ImgDetMain", // Insérez l'URL de votre image ici
    ),
    Event(
      title: "Autre événement",
      description: "Description de l'événement",
      date: "Vendredi 19 Avril 2024",
      location: "20 Rue de Strasbourg 44000 Nantes",
      style: "Festif",
      imageUrl: "https://th.bing.com/th/id/OIP.bOYyTEu7iYJZfczpU7_81wAAAA?rs=1&pid=ImgDetMain", // Insérez l'URL de votre image ici
    ),
    // Ajoutez autant d'événements que vous le souhaitez
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
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
              // Affichage de l'image de l'événement avec un BorderRadius
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  event.imageUrl,
                  //width: double.infinity,
                  height: 250, // Ajustez la hauteur de l'image selon vos besoins
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              // Affichage du style de l'événement
              Text(
                event.style,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
              // Affichage du titre de l'événement
              Text(
                event.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              // Affichage de la date de l'événement
              Text(
                event.date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 4.0),
              // Affichage du lieu de l'événement
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
        );
      },
    );
  }

}

