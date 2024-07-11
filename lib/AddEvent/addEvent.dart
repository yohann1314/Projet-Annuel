import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _artistNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _eventDetailController = TextEditingController();
  final TextEditingController _eventProgramController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  File? _imageFile;
  bool _isUploading = false;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('event_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Failed to upload image to Firebase Storage: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du téléchargement de l\'image: $e')),
      );
      return null;
    }
  }

  Future<void> _addEvent() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUploading = true;
      });

      String artistName = _artistNameController.text;
      try {
        // Récupérer l'ID de l'artiste à partir de la collection artist
        QuerySnapshot artistSnapshot = await FirebaseFirestore.instance
            .collection('artist')
            .where('artistName', isEqualTo: artistName)
            .get();

        if (artistSnapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Artiste non trouvé')),
          );
          setState(() {
            _isUploading = false;
          });
          return;
        }

        String artistId = artistSnapshot.docs.first.id;

        // Charger l'image sur Firebase Storage et obtenir l'URL
        if (_imageFile != null) {
          _imageUrl = await _uploadImage(_imageFile!);
        }

        if (_imageUrl == null) {
          setState(() {
            _isUploading = false;
          });
          return;
        }

        // Ajouter l'événement dans la collection event
        await FirebaseFirestore.instance.collection('event').add({
          'artistId': artistId,
          'date': _dateController.text,
          'description': _descriptionController.text,
          'eventDetail': _eventDetailController.text,
          'eventProgram': _eventProgramController.text,
          'imageUrl': _imageUrl,
          'location': _locationController.text,
          'style': _styleController.text,
          'title': _titleController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Événement ajouté avec succès!')),
        );

        _formKey.currentState!.reset();
        setState(() {
          _imageFile = null;
          _isUploading = false;
          _imageUrl = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Une erreur est survenue: $e')),
        );
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _artistNameController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _eventDetailController.dispose();
    _eventProgramController.dispose();
    _locationController.dispose();
    _styleController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un événement', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12112D),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFF12112D),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _artistNameController,
                decoration: InputDecoration(labelText: 'Nom de l\'artiste', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de l\'artiste';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              _buildLabeledTextArea(
                controller: _eventDetailController,
                label: 'Détails de l\'événement',
              ),
              SizedBox(height: 16),
              _buildLabeledTextArea(
                controller: _eventProgramController,
                label: 'Programme de l\'événement',
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Adresse', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'adresse';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _styleController,
                decoration: InputDecoration(labelText: 'Style', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le style';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titre', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le titre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Choisir une image'),
              ),
              SizedBox(height: 20),
              _imageFile == null
                  ? const Text('Aucune image sélectionnée', style: TextStyle(color: Colors.white))
                  : Image.file(_imageFile!),
              SizedBox(height: 20),
              _isUploading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _addEvent,
                child: const Text('Ajouter l\'événement'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextArea({
    required TextEditingController controller,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: 5, // Vous pouvez ajuster le nombre de lignes ici
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer les détails';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
