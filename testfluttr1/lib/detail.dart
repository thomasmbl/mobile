import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 30, 38, 44),
        leading: IconButton(
          icon: SvgPicture.asset(
            'images/back.svg',
          ),
          onPressed: () {
            // do something
          },
        ),
        title: const Text('Détail du jeu'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'images/like_full.svg',
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'images/whishlist_full.svg',
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(250, 30, 38, 44),
    );
  }
}
