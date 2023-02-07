import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class EmptyListe extends StatelessWidget {
  const EmptyListe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 30, 38, 44),
        leading: IconButton(
            icon: SvgPicture.asset(
              'images/close.svg',
            ),
            onPressed: () {
              // do something
            },
          ),
        title: const Text('Ma liste de souhaits'),
      ),
      backgroundColor: Color.fromARGB(250, 30, 38, 44),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/empty_whishlist.svg',
            ),
            const SizedBox(height: 40),
            const Text("Vous n'avez encore pas liké de contenu.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text("Cliquez sur l'étoile pour en rajouter",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
