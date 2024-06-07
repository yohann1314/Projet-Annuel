import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final String imageUrl;
  final String style;
  final String title;
  final String date;
  final String location;
  final String artistImageUrl;
  final String artistName;
  final String artistStyle;
  final String eventDetails;
  final String eventProgram;

  EventDetailPage({
    required this.imageUrl,
    required this.style,
    required this.title,
    required this.date,
    required this.location,
    required this.artistImageUrl,
    required this.artistName,
    required this.artistStyle,
    required this.eventDetails,
    required this.eventProgram,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      backgroundColor: const Color(0xFF1E5B67),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              location,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipOval(
                  child: Image.network(
                    artistImageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artistName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      artistStyle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Action pour suivre l'artiste
                  },
                  child: Text('Suivre'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Action pour inviter des amis
              },
              icon: Icon(Icons.person_add),
              label: Text('Inviter des amis'),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Détails de l\'événement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    eventDetails,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Programme de l\'événement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    eventProgram,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}








/*  PROMPTS

creer une page eventdetail.dart qui contiendra les détails de l'événement disposé comme suit :
- L'image de l'événement
- Le style de l'événement
- Le titre de l'événement
- La date de l'événement
- Le lieu de l'événement
- un bloc rectangulaire avec la photo en rod de l'artiste de l'evenement, le nom de l'artiste, son  style de musique et tout à droite un bouton pour suivre l'artiste
- un bouton pour inviter des amis à l'événement avec une icone d'invitation
- un bloc detail de l'evenement  avec le titre "Détails de l'événement" et un texte qui contient les détails de l'événement et le lieu de l'événement
- un bloc programme de l'evenement avec le titre "Programme de l'événement" et un texte qui contient le programme de l'événement
  */