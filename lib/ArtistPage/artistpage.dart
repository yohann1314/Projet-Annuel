import 'package:flutter/material.dart';

class ArtistPage extends StatelessWidget {
  final String artistImageUrl;
  final String artistName;
  final String artistDescription;
  final String artistStyle;
  final List<Event> artistEvents;
  final List<Event> similarEvents;

  ArtistPage({
    required this.artistImageUrl,
    required this.artistName,
    required this.artistDescription,
    required this.artistStyle,
    required this.artistEvents,
    required this.similarEvents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12112D),
      appBar: AppBar(
        title: Text(artistName),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.network(
                        artistImageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          artistName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Action pour suivre l'artiste
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF9C3EAE),
                          ),
                          child: Text(
                            'Suivre',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                artistDescription,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              const Text(
                'Événements de l\'artiste',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: artistEvents.length,
                itemBuilder: (context, index) {
                  final event = artistEvents[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Image.network(
                        event.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        event.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.date,
                            style: const TextStyle(
                              color: Color(0xFF9C3EAE),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            event.location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Action pour voir les détails de l'événement
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9C3EAE),
                        ),
                        child: const Text(
                          'Détails',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Événements similaires',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: similarEvents.length,
                  itemBuilder: (context, index) {
                    final event = similarEvents[index];
                    return Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            event.imageUrl,
                            width: 120,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            event.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            event.date,
                            style: TextStyle(
                              color: Color(0xFF9C3EAE),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            event.location,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Event {
  final String imageUrl;
  final String title;
  final String date;
  final String location;

  Event({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
  });
}
