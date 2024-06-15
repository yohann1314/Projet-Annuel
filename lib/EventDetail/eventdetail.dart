import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ArtistPage/artistpage.dart';

class EventDetailPage extends StatefulWidget {
  final String imageUrl;
  final String style;
  final String title;
  final String date;
  final String location;
  final String artistId;
  final String eventDetail;
  final String eventProgram;

  EventDetailPage({
    required this.imageUrl,
    required this.style,
    required this.title,
    required this.date,
    required this.location,
    required this.artistId,
    required this.eventDetail,
    required this.eventProgram,
  });

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  String artistImageUrl = '';
  String artistName = '';
  String artistStyle = '';
  String artistDescription = '';
  bool isLoading = true;
  String errorMessage = '';
  List<Event> artistEvents = [];
  List<Event> similarEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchArtistDetails();
  }

  void _fetchArtistDetails() async {
    try {
      DocumentSnapshot artistSnapshot = await FirebaseFirestore.instance.collection('artist').doc(widget.artistId).get();
      if (artistSnapshot.exists) {
        setState(() {
          artistImageUrl = artistSnapshot['artistImageUrl'] ?? '';
          artistName = artistSnapshot['artistName'] ?? '';
          artistStyle = artistSnapshot['artistStyle'] ?? '';
          artistDescription = artistSnapshot['artistDescription'] ?? '';
        });
        _fetchArtistEvents();
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Artiste non trouvé';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Erreur de chargement de l\'artiste: $e';
      });
    }
  }

  void _fetchArtistEvents() async {
    try {
      QuerySnapshot eventSnapshot = await FirebaseFirestore.instance
          .collection('event')
          .where('artistId', isEqualTo: widget.artistId)
          .get();
      setState(() {
        artistEvents = eventSnapshot.docs.map((doc) {
          return Event(
            imageUrl: doc['imageUrl'],
            title: doc['title'],
            date: doc['date'],
            location: doc['location'],
            style: doc['style'],
          );
        }).toList();
      });
      _fetchSimilarEvents();
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Erreur de chargement des événements: $e';
      });
    }
  }

  void _fetchSimilarEvents() async {
    try {
      // Récupérer les styles des événements de l'artiste
      Set<String> eventStyles = artistEvents.map((event) => event.style).toSet();

      // Récupérer les événements similaires ayant l'un des styles
      QuerySnapshot similarEventSnapshot = await FirebaseFirestore.instance
          .collection('event')
          .where('style', whereIn: eventStyles.toList())
          .get();

      setState(() {
        similarEvents = similarEventSnapshot.docs.map((doc) {
          return Event(
            imageUrl: doc['imageUrl'],
            title: doc['title'],
            date: doc['date'],
            location: doc['location'],
            style: doc['style'],
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Erreur de chargement des événements similaires: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      backgroundColor: const Color(0xFF12112D),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (errorMessage.isEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.date,
                style: const TextStyle(
                  color: Color(0xFF00FF38),
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.location,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArtistPage(
                        artistImageUrl: artistImageUrl,
                        artistName: artistName,
                        artistStyle: artistStyle,
                        artistDescription: artistDescription,
                        artistEvents: artistEvents,
                        similarEvents: similarEvents,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
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
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            artistStyle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
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
                ),
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
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
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
                          widget.eventDetail,
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
                      color: Colors.white.withOpacity(0.06),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
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
                          widget.eventProgram,
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
            ],
          ],
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
  final String style;  // Ajouter le style ici

  Event({
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.location,
    required this.style,  // Mettre à jour le constructeur
  });
}

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
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
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
                    color: Colors.black,
                    child: ListTile(
                      leading: Image.network(
                        event.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        event.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.date,
                            style: TextStyle(
                              color: Color(0xFF9C3EAE),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            event.location,
                            style: TextStyle(
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
                        child: Text(
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
              SizedBox(height: 20),
              Text(
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
                        color: Color(0xFFEAB3F4),
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
