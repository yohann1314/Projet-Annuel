import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartePage extends StatelessWidget {
  final String apiKey = '6679a8cb403b7637395389yls8bf76c'; // Clé API pour l'API de géocodage
  final Map<String, LatLng> _geocodingCache = {};

  Future<LatLng> _geocode(String address) async {
    if (_geocodingCache.containsKey(address)) {
      return _geocodingCache[address]!;
    }

    final url = Uri.parse(
      'https://geocode.maps.co/search?q=${Uri.encodeComponent(address)}&api_key=$apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse.isNotEmpty) {
        final location = jsonResponse[0];
        final coordinates = LatLng(double.parse(location['lat']), double.parse(location['lon']));
        _geocodingCache[address] = coordinates;
        return coordinates;
      } else {
        throw Exception('No results found for address: $address');
      }
    } else {
      throw Exception('Failed to load geocoding data');
    }
  }

  void _showEventDialog(BuildContext context, Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF12112D), // Couleur de fond de la boîte de dialogue
          title: Text(
            event['title'] ?? 'Sans titre',
            style: const TextStyle(color: Colors.white), // Texte blanc
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${event['date'] ?? 'Inconnue'}', style: const TextStyle(color: Colors.white)), // Texte blanc
              const SizedBox(height: 10),
              Text('Adresse: ${event['location'] ?? 'Inconnue'}', style: const TextStyle(color: Colors.white)), // Texte blanc
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Fermer', style: TextStyle(color: Colors.white)), // Texte blanc
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('event').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Une erreur est survenue'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Pas d\'événements disponibles'));
          }

          List<DocumentSnapshot> events = snapshot.data!.docs;

          return FutureBuilder<List<Marker>>(
            future: Future.wait(events.map((eventDoc) async {
              final event = eventDoc.data() as Map<String, dynamic>;
              final address = event['location'] as String;

              try {
                final coordinates = await _geocode(address); // Géocodage de l'adresse
                return Marker(
                  width: 80.0,
                  height: 80.0,
                  point: coordinates,
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      _showEventDialog(ctx, event);
                    },
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ),
                );
              } catch (e) {
                print('Erreur de géocodage pour l\'adresse "$address": $e');
                return Marker(
                  width: 0.0,
                  height: 0.0,
                  point: LatLng(0, 0),
                  builder: (ctx) => Container(),
                );
              }
            }).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Une erreur est survenue lors du géocodage'));
              }

              return FlutterMap(
                options: MapOptions(
                  center: LatLng(47.2184, -1.5536),
                  zoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    userAgentPackageName: 'projet_annuel',
                  ),
                  MarkerLayer(
                    markers: snapshot.data?.where((marker) => marker.width > 0.0).toList() ?? [],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}