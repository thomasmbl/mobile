import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'inscription.dart';
import 'motDePasse.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 30, 38, 44),
      body: Center(
        child: Column(
          children: [
            Container(
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
                  Text("Veuillez vous connecter ou créer un nouveau"
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
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  TextField(
                    //onChanged: (value) => setState(() => _email = value ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        //labelText: 'E-mail',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromARGB(255, 30, 38, 44),
                        hintText: "E-mail",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color.fromARGB(255, 30, 38, 44),
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
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
                  onPressed: () {},
                ),
                const SizedBox(height: 30),
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
                  child: const Text("Créer un nouveau compte"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InscriptionPage(),));
                  },
                ),
                const SizedBox(height: 80),
                TextButton (
                  style: (
                      TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      )
                  ),
                  child: const Text("Mot de passe oublié",
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
