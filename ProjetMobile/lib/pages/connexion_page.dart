import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testfluttr1/pages/accueil.dart';
import 'package:testfluttr1/services/authentification.dart';
import 'inscription.dart';
import 'loading.dart';
import 'motDePasse.dart';

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}


class _ConnexionPageState extends State<ConnexionPage> {
  final AuthentificationService _auth = AuthentificationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /*
  void toggleView() {
    setState(() {
      emailController.text = '';
      passwordController.text = '';
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :
    Scaffold(
      backgroundColor: Color.fromARGB(250, 30, 38, 44),
      body: Center(
        child: Column(
          children: [
            Container(
              /*
              * decoration: const BoxDecoration(
                image:DecorationImage (
                  image: AssetImage("background.jpeg")
                )
              ),
              * */

              margin: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 140,
              ),
              child: Column(
                children: const [
                  SizedBox(height: 30),
                  Text("Bienvenue !",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),),
                  SizedBox(height: 20),
                  Text("Veuillez vous connecter ou cr??er un nouveau"
                      " compte pour utiliser l'application.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 100,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      //onChanged: (value) => setState(() => _email = value ),
                      controller: emailController,
                      validator: (value) => value?.isEmpty ?? true ? "Entrer un email" : null,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          //labelText: 'E-mail',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 30, 38, 44),
                          hintText: "E-mail",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) => value != null && value.length < 6 ? "Entrer un mot de passe d'au moins 6 caract??res" : null,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color.fromARGB(255, 30, 38, 44),
                          hintText: 'Mot de passe',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          )
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            Column(
              children: [
                TextButton (
                  style: (
                      TextButton.styleFrom(
                        fixedSize: const Size.fromWidth(300),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 99, 106, 246),
                        elevation: 0,
                      )
                  ),
                  child: const Text("Se connecter"),
                  onPressed: () async {

                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true );
                      var password = passwordController.value.text;
                      var email = emailController.value.text;

                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Entrer une adresse valide';
                        });
                      }
                      else{
                        setState(() {
                          loading = false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Accueil()));
                      }
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 15.0),
                ),
                SizedBox(height: 15),
                TextButton (
                  style: (
                    TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      fixedSize: const Size.fromWidth(300),
                      shape: const RoundedRectangleBorder(side: BorderSide(
                        color: Color.fromARGB(255, 99, 106, 246),
                        width: 1,
                      ),),
                    )
                  ),
                  child: const Text("Cr??er un nouveau compte"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InscriptionPage(),));
                  },
                ),
                const SizedBox(height: 40),
                TextButton (
                  style: (
                      TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      )
                  ),
                  child: const Text("Mot de passe oubli??",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MotDePasseOublie(),));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
