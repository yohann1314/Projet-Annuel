import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: FutureBuilder<Map<String, String>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching user data: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return UserProfilePage(
              userName: snapshot.data!['lastName']!,
              userFirstName: snapshot.data!['firstName']!,
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
                Event(
                  imageUrl: 'https://www.example.com/event2.jpg',
                  title: 'Concert 3',
                  date: '2024-08-15',
                  location: 'Venue 2',
                ),
                Event(
                  imageUrl: 'https://www.example.com/event2.jpg',
                  title: 'Concert 4',
                  date: '2024-08-15',
                  location: 'Venue 2',
                ),
                Event(
                  imageUrl: 'https://www.example.com/event2.jpg',
                  title: 'Concert 5',
                  date: '2024-08-15',
                  location: 'Venue 2',
                ),
              ],
            );
          } else {
            return Center(child: Text('No user data found'));
          }
        },
      ),
    );
  }

  Future<Map<String, String>> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          String firstName = userDoc['firstName'];
          String lastName = userDoc['lastName'];
          return {'firstName': firstName, 'lastName': lastName};
        } else {
          throw 'User document does not exist';
        }
      } catch (e) {
        throw 'Failed to fetch user data: $e';
      }
    } else {
      throw 'User is not authenticated';
    }
  }
}

class UserProfilePage extends StatefulWidget {
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
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isPro = false;

  @override
  void initState() {
    super.initState();
  }

  void updateProStatus(bool newProStatus) {
    setState(() {
      isPro = newProStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12112D),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              HeaderSection(
                userFirstName: widget.userFirstName,
                userName: widget.userName,
                isPro: isPro,
                onProStatusChanged: updateProStatus,
              ),
              const SizedBox(height: 18),
              const SectionsRow(),
              const SizedBox(height: 18),
              if (!isPro) ...[
                PrepareSortiesWidget(friendsCount: 0), // Exemple avec 0 amis
                const SizedBox(height: 20),
                GroupesWidget(),
                const SizedBox(height: 18),
                SavedEventsSection(savedEvents: widget.savedEvents)
              ] else ...[
                const SizedBox(height: 22),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Action pour ajouter un nouvel événement
                      // (Vous pouvez implémenter cette action selon vos besoins)
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9C3EAE),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        minimumSize: Size(250, 60),
                    ),

                    child: Text('Creer un nouvel événement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                MyEventsSection(savedEvents: widget.savedEvents),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatefulWidget {
  final String userFirstName;
  final String userName;
  final bool isPro;
  final Function(bool) onProStatusChanged;

  const HeaderSection({
    required this.userFirstName,
    required this.userName,
    required this.isPro,
    required this.onProStatusChanged,
  });


  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  String? profileImageUrl;
  bool isPro = false;

  @override
  void initState() {
    super.initState();
    fetchProfileImageUrl();
    fetchProStatus();
  }

  Future<void> fetchProStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc['pro'] != null) {
          setState(() {
            isPro = userDoc['pro'];
          });
          widget.onProStatusChanged(isPro);  // Notify parent of initial status
        } else {
          throw 'Pro status not found';
        }
      } catch (e) {
        print('Failed to fetch pro status: $e');
      }
    }
  }

  Future<void> updateProStatus(bool newProStatus) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'pro': newProStatus,
        });
        setState(() {
          isPro = newProStatus;
        });
        widget.onProStatusChanged(isPro);  // Notify parent of status change
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vous etes passé.e en statut pro'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        print('Failed to update pro status: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update Pro status: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  Future<void> fetchProfileImageUrl() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc['profileImageUrl'] != null) {
          setState(() {
            profileImageUrl = userDoc['profileImageUrl'];
          });
        } else {
          throw 'Profile image URL not found';
        }
      } catch (e) {
        print('Failed to fetch profile image URL: $e');
      }
    }
  }

  Future<void> _changeProfileImage() async {
    File? imageFile = await pickImage();
    if (imageFile != null) {
      try {
        String? imageUrl = await uploadImageToFirebase(imageFile);
        if (imageUrl != null) {
          await updateProfileImageUrl(imageUrl);
          setState(() {
            profileImageUrl = imageUrl;
          });
        } else {
          throw 'Failed to upload image to Firebase Storage';
        }
      } catch (e) {
        print('Failed to change profile image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change profile image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${user.uid}.jpg');

        UploadTask uploadTask = storageRef.putFile(imageFile);
        TaskSnapshot storageSnapshot = await uploadTask;

        return await storageSnapshot.ref.getDownloadURL();
      } catch (e) {
        print('Failed to upload image to Firebase Storage: $e');
        return null;
      }
    }
    return null;
  }

  Future<void> updateProfileImageUrl(String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'profileImageUrl': imageUrl,
        });
      } catch (e) {
        print('Failed to update profile image URL: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile image URL: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _changeProfileImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl!) as ImageProvider<Object> : AssetImage('assets/default_profile_image.png') as ImageProvider<Object>,
                child: profileImageUrl == null ? Icon(Icons.camera_alt, color: Colors.white) : null, // Condition added here
              ),
            ),
            const SizedBox(width: 20),
            Text(
              '${widget.userFirstName} ${widget.userName}',
              style: const TextStyle(
                fontFamily: 'InriaSans',
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isPro ? Colors.yellow : Colors.grey, // Couleur en or pour Pro, gris pour Standard
          ),
          onPressed: () {
            // Action pour changer le statut Pro
            updateProStatus(!isPro); // Inverse le statut actuel
          },
          child: Text(
            isPro ? 'Pro' : 'Standard',
            style: TextStyle(
              color: Color(0xFF545367),
            ),
          ),
        ),
      ],
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0), // Ajuster la distance entre chaque section
            child: Column(
              children: [
                SectionWidget(section: section),
              ],
            ),
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
            fontSize: 18,
            color: Colors.white,
            fontFamily: "InriaSans",
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
            fontSize: 18,
            color: Colors.white,
            fontFamily: "InriaSans",
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Rassemble tes amis, vote pour les événements et',
          style: TextStyle(
            fontSize: 12,
            fontFamily: "InriaSans",
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'découvre qui y va.',
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
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
          Container(
          height: 150,
          child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
            scrollDirection: Axis.vertical,
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
        ),
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

class EventDetailPage2 extends StatelessWidget {
  final Event event;

  const EventDetailPage2({required this.event});

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

void openEventDetail2(Event event, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EventDetailPage2(event: event),
    ),
  );
}

class MyEventsSection extends StatelessWidget {
  final List<Event> savedEvents;

  const MyEventsSection({required this.savedEvents});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mes événements', // Changed title for pro users
          style: TextStyle(
            color: Colors.white,
            fontFamily: "InriaSans",
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              scrollDirection: Axis.vertical,
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
                        openEventDetail2(event, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C3EAE),
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
          ),
        ),
      ],
    );
  }
}