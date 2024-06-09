import 'package:flutter/material.dart';
import 'package:projet_annuel/login/auth_service.dart';
import 'package:projet_annuel/login/authentification.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final email = _emailController.text;
      final password = _passwordController.text;

      final result = await AuthService().registration(email: email, password: password);

      if (result == 'Success') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AuthentificationPage(),
          ),
        );
      } else {
        setState(() {
          _errorMessage = result;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF12112D),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Inscription',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: "Mot de passe",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: _isLoading ? CircularProgressIndicator() : Text('S\'inscrire'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
