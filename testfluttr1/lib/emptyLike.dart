import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class EmptyLike extends StatelessWidget {
  const EmptyLike({Key? key}) : super(key: key);

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
        title: const Text('Mes likes'),
      ),
      backgroundColor: Color.fromARGB(250, 30, 38, 44),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/empty_likes.svg',
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
            const Text("Cliquez sur le coeur pour en rajouter",
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
