import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projet_annuel/inscription/inscription.dart';
import 'package:projet_annuel/Profil/profil.dart';
import 'package:projet_annuel/Recherche/recherche.dart';
import 'package:projet_annuel/Carte/carte.dart';
import 'package:projet_annuel/login/authentification.dart';
import 'package:projet_annuel/testeEventPage/event_page.dart';
import 'package:projet_annuel/Home/home.dart'; // Importez uniquement depuis home.dart
import 'package:projet_annuel/bottom_navigation.dart'; // Importez votre barre de navigation

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/', // Route initiale
      routes: {
        '/': (context) => AuthentificationPage(), // Page de connexion
        '/inscription': (context) => InscriptionPage(), // Page d'inscription
        '/home': (context) => HomePage(), // Page d'accueil depuis home.dart
        '/carte': (context) => const BottomNavigation(), // Utilisation de la barre de navigation
        '/recherche': (context) => const BottomNavigation(), // Utilisation de la barre de navigation
        '/profil': (context) => const BottomNavigation(), // Utilisation de la barre de navigation
      },
    );
  }
}
