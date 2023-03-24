import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SteamUsername extends StatefulWidget {
  final String steamID;

  SteamUsername({required this.steamID});


  @override
  _SteamUsernameState createState() => _SteamUsernameState();
}

class _SteamUsernameState extends State<SteamUsername> {
  String _username = '';

  Future<void> _getUsername(String steamId) async {
    final response = await http.get(
        Uri.parse('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/'
            '?key=B7ABBB155FF3A1AE5A0EFB9D78A7FCDE&steamids=$steamId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        _username = jsonResponse['response']['players'][0]['personaname'];
      });
    } else {
      throw Exception('Failed to load username');
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsername(widget.steamID);
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_username', style: TextStyle(
      fontSize: 18,
      color: Colors.white,
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
      decorationThickness: 1,
      decorationStyle: TextDecorationStyle.solid,
    ));

  }
}
