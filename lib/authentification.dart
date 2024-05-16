import 'package:flutter/material.dart';

class AuthentificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF12112D),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80), // Ajustez la valeur de top selon votre préférence
            child: Text(
              "EventHub",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60, // Taille de la police
                fontWeight: FontWeight.bold, // Police en gras
                fontFamily: 'Arial', // Remplacez "VotrePolice" par le nom de votre police
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 200),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ), 
                        labelText: "Email", 
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (true == true) {
                          // Navigate the user to the Home page
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20, color: Colors.black),
                        minimumSize: Size(double.infinity, 60), // Taille du texte du bouton
                        padding: EdgeInsets.symmetric(vertical: 18), 
                        backgroundColor: Colors.white,// Ajustez la hauteur du bouton
                        shape: StadiumBorder(),// Autres propriétés de style que vous pouvez spécifier
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
