import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testfluttr1/pages/accueil.dart';
import 'package:testfluttr1/pages/connexion_page.dart';

import '../models/user.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return ConnexionPage();
    } else {
      return Accueil();
    }
  }
}
