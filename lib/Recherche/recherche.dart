import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../EventDetail/eventdetail.dart';

class RecherchePage extends StatefulWidget {
  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher des événements...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          ),
          style: TextStyle(color: Colors.white, fontSize: 18.0),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
        ),
        backgroundColor: const Color(0xFF12112D),
      ),
      backgroundColor: const Color(0xFF12112D),
      body: StreamBuilder<QuerySnapshot>(
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

          List<DocumentSnapshot> events = snapshot.data!.docs.where((event) {
            final eventData = event.data() as Map<String, dynamic>;
            final title = eventData['title']?.toLowerCase() ?? '';
            return title.contains(_searchQuery);
          }).toList();

          if (events.isEmpty) {
            return Center(child: Text('Aucun événement trouvé', style: TextStyle(color: Colors.white)));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index].data() as Map<String, dynamic>;
              final imageUrl = event['imageUrl'] ?? '';
              final style = event['style'] ?? '';
              final title = event['title'] ?? '';
              final date = event['date'] ?? '';
              final location = event['location'] ?? '';
              final artistId = event['artistId'] ?? '';
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
      ),
    );
  }
}
