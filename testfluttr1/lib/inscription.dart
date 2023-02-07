import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InscriptionPage extends StatelessWidget {
  const InscriptionPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black38,
      backgroundColor: Color.fromARGB(250, 30, 38, 44),
      body: Center(
        child: Column(
          children: [
            /*
            SvgPicture.asset(
              'images/back.svg',
            ),
            */
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 80,
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Inscription",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 22),
                  Text(
                    "Veuillez saisir ces différentes informations, afin que vos listes soient sauvegardées.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            //TextFormField(),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Nom d'utilisateur",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color.fromARGB(255, 30, 38, 44),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color.fromARGB(255, 30, 38, 44),
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
                      hintText: 'Mot de passe',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color.fromARGB(255, 30, 38, 44),
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
                      hintText: 'Vérification du mot de passe',
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color.fromARGB(255, 30, 38, 44),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),

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
                  child: const Text("S'inscrire"),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
