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
