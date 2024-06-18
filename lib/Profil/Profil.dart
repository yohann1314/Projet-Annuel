import 'package:flutter/material.dart';

void main() {
  runApp(const Profil());
}

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: UserProfilePage(
        userName: 'Mutikanga',
        userFirstName: 'Gedeon',
        friends: [],
        followedArtists: [],
        savedLocations: [],
        savedEvents: [
          Event(
            imageUrl: 'https://www.example.com/event1.jpg',
            title: 'Concert 1',
            date: '2024-07-10',
            location: 'Venue 1',
          ),
          Event(
            imageUrl: 'https://www.example.com/event2.jpg',
            title: 'Concert 2',
            date: '2024-08-15',
            location: 'Venue 2',
          ),
        ],
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final String userName;
  final String userFirstName;
  final List<String> friends;
  final List<String> followedArtists;
  final List<String> savedLocations;
  final List<Event> savedEvents;

  const UserProfilePage({
    required this.userName,
    required this.userFirstName,
    required this.friends,
    required this.followedArtists,
    required this.savedLocations,
    required this.savedEvents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12112D),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              HeaderSection(
                userFirstName: userFirstName,
                userName: userName,
              ),
              const SizedBox(height: 20),
              const SectionsRow(),
              const SizedBox(height: 20),
              PrepareSortiesWidget(friendsCount: 0), // Exemple avec 0 amis
              const SizedBox(height: 20),
              GroupesWidget(),
              const SizedBox(height: 50),
              SavedEventsSection(savedEvents: savedEvents),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String userFirstName;
  final String userName;

  const HeaderSection({
    required this.userFirstName,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                'https://www.example.com/user-profile-image.jpg', // Replace with actual image URL
              ),
            ),
            const SizedBox(width: 20),
                Text(
                  '$userFirstName $userName',
                  style: const TextStyle(
                    fontFamily: 'InriaSans',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // Action to open settings
          },
        ),
      ],
    );
  }
}

class PrepareSortiesWidget extends StatelessWidget {
  final int friendsCount;

  const PrepareSortiesWidget({required this.friendsCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text(
              'Prépare tes sorties',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Row(
            children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  '$friendsCount/3',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  'Suis 3 ami.e.s',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'InriaSans',
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Regarde ce qui les intéresse. On vous recommandera',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontFamily: 'InriaSans',
                  ),
                ),
                  SizedBox(height: 5),
                  Text(
                    ' des événements où aller ensemble.',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontFamily: 'InriaSans',
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
      ],
    ),
    ],
    );
  }
}


class GroupesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(

          'Groupes',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Rassemble tes amis, vote pour les événements et découvre qui y va.',
          style: TextStyle(
            fontSize: 12,
            fontFamily: "InriaSans",
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GroupSectionWidget(title: 'Groupe 1'),
              GroupSectionWidget(title: 'Groupe 2'),
              GroupSectionWidget(title: 'Groupe 3'),
              GroupSectionWidget(title: 'Groupe 4'),
              GroupSectionWidget(title: 'Groupe 5'),
              GroupSectionWidget(title: 'Groupe 6'),
              GroupSectionWidget(title: 'Groupe 7'),
              GroupSectionWidget(title: 'Groupe 8'),
              // Ajoutez d'autres GroupSectionWidget ici selon vos besoins
            ],

          ),
        ),
      ],
    );
  }
}

class GroupSectionWidget extends StatelessWidget {
  final String title;

  GroupSectionWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7A78B4), // Couleur en haut
            Color(0xFF1C1B5B), // Couleur en bas
          ],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SectionsRow extends StatelessWidget {
  const SectionsRow();

  @override
  Widget build(BuildContext context) {
    List<SectionItem> sections = [
      SectionItem(
        title: 'Ami.e.s',
        onTap: () {
          // Action lorsque "Ami.e.s" est tapé
        },
      ),
      SectionItem(
        title: 'Artistes',
        onTap: () {
          // Action lorsque "Artistes" est tapé
        },
      ),
      SectionItem(
        title: 'Lieux',
        onTap: () {
          // Action lorsque "Lieux" est tapé
        },
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: sections.map((section) {
        return Expanded(
          child: Column(
            children: [
              SectionWidget(section: section),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class SectionItem {
  final String title;
  final VoidCallback onTap;

  SectionItem({
    required this.title,
    required this.onTap,
  });
}

class SectionWidget extends StatelessWidget {
  final SectionItem section;

  const SectionWidget({required this.section});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: section.onTap,
      child: Container(
        height: 55,
        width: 95,
        decoration: BoxDecoration(
          color: Color(0xFF545367),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            Text(
              '+',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'InriaSans',
              ),
            ),
            const SizedBox(height: 0.0),
            Text(
              section.title,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontFamily: 'InriaSans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedEventsSection extends StatelessWidget {
  final List<Event> savedEvents;

  const SavedEventsSection({required this.savedEvents});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sauvegardé',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "InriaSans",
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: savedEvents.map((event) {
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
// Action to see event details
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C3EAE), // Background color
                  ),
                  child: const Text(
                    'Voir plus',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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

class EventDetailPage extends StatelessWidget {
  final Event event;

  const EventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              event.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              'Date: ${event.date}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Location: ${event.location}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void openEventDetail(Event event, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventDetailPage(event: event),
    ),
  );
}
