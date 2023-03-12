import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:testfluttr1/pages/connexion_page.dart';
import 'package:testfluttr1/pages/meswhish.dart';
import 'package:testfluttr1/pages/recherche.dart';
import 'package:testfluttr1/services/authentification.dart';

import '../models/user.dart';
import '../services/database.dart';
import 'detail.dart';
import 'meslikes.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final AuthentificationService _auth = AuthentificationService();

  List<dynamic> _mpGamesID = [];
  Map<int, dynamic> _mpGame = {};

  Future<void> _fetchGames() async {
    final response = await http.get(Uri.parse('https://cors-anywhere.herokuapp.com/'
        'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/'
        '?key=B7ABBB155FF3A1AE5A0EFB9D78A7FCDE'));
    if (response.statusCode == 200) {
      final List<dynamic> gamesIDList = jsonDecode(response.body)['response']['ranks'].take(10).toList();
      setState(() {
        _mpGamesID = gamesIDList;
      });
      for (final gameID in gamesIDList) {
        await fetchGameDetails(gameID['appid']);
      }
    } else {
      throw Exception('Failed to fetch most played games from API');
    }
  }


  Future<void> fetchGameDetails(int appId) async {
    final response = await http.get(Uri.parse('https://cors-anywhere.herokuapp.com/'
        'https://store.steampowered.com/api/appdetails?appids=$appId'
        '&cc=FR&l=fr&key=B7ABBB155FF3A1AE5A0EFB9D78A7FCDE'));
    if (response.statusCode == 200) {
      Map<String, dynamic> gameData = jsonDecode(response.body) as Map<String, dynamic>;
      if (gameData[appId.toString()]?["success"] == true) {
        setState(() {
          _mpGame[appId] = gameData[appId.toString()]?["data"];
        });
      }
    } else {
      throw Exception('Failed to fetch game details from API');
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) throw Exception("utilisateur introuvable");
    final database = DatabaseService(user.uid);
    return StreamProvider<AppUserData>.value(
      initialData: AppUserData(
        uid: "",
        name: "",
        likes: [],
        wishlist: [],
      ),
      value: database.user,
      child: Scaffold(
        backgroundColor: Color.fromARGB(250, 30, 38, 44),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(250, 30, 38, 44),
          title: Text('Accueil'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  )
                ),
              ),
            ),
          ),

          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                'images/like.svg',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MesLikes()));
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                'images/whishlist.svg',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MesWish()));
              },
            ),
            TextButton.icon(
              style: (
                  TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(250, 30, 38, 44),
                    elevation: 0,
                  )
              ),
              icon: Icon(Icons.person),
              label: Text('Déconnexion'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConnexionPage()));
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Color.fromARGB(255, 30, 38, 44),
                  hintText: 'Rechercher un jeu...',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  suffixIcon: Icon(Icons.search, color: Color.fromARGB(255, 100, 107, 248)),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Stack(
                      children: [
                        Container(
                          child: Image.network(
                            'https://cdn.akamai.steamstatic.com//steam//apps//'
                                '2050420//ss_ac5fcc8e05ca2ce21548413bdd2024936dbf7966.1920x1080.jpg?t=1655250428',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                          ),
                        ),
                        Positioned(
                          bottom: 166.0,
                          left: 0.0,
                          child: Container(
                            color: Colors.black38,
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'ARK 2',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 70.0,
                          left: 0.0,
                          child: Container(
                            width: 250,
                            color: Colors.black38,
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Survivez au passé. Apprivoiser le futur. "
                                  "Soudain réveillé dans un monde primitif "
                                  "rempli de dinosaures....",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Details(appID: 2050420)));
                              },
                              child: Text(
                                "En savoir plus",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(197, 40),
                                backgroundColor: const Color.fromARGB(255, 99, 106, 246),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -8.0,
                          right: -8.0,
                          child: Container(
                            width: 250,
                            padding: EdgeInsets.all(16.0),
                            child: Image.network(
                              "https:\/\/cdn.akamai.steamstatic.com\/steam\/apps\/2050420\/header.jpg?t=1655250428"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "Les meilleures ventes",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 1,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _mpGamesID.length,
                    itemBuilder: (context, index) {
                      final gameID = _mpGamesID[index];
                      final game = _mpGame[gameID['appid']];

                      return Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                image: NetworkImage(game?['header_image'] ?? ''),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.8),
                                  BlendMode.darken,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: Stack(
                                children: [
                                  Image.network(
                                    game?['header_image'] ?? '',
                                  ),
                                ],
                              ),
                              title: Text(game?['name'] ?? '', style: TextStyle(color: Colors.white)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      game != null && game['publishers'] != null ?
                                      '${game['publishers']}'
                                          : '',
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                      game != null && game['price_overview'] != null ?
                                      'Prix : ${game['price_overview']['final_formatted']}'
                                          : 'Prix : Gratuit',
                                      style: TextStyle(color: Colors.white)
                                  ),
                                ],
                              ),
                              trailing: SizedBox(
                                  height: 200,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Details(appID: gameID['appid'])));
                                    },
                                    child: Column(
                                      children: [
                                        Text('En savoir plus',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(100, 100),
                                      backgroundColor: const Color.fromARGB(255, 99, 106, 246),
                                    ),
                                  ),
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ],
                      );



                      /*Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(game?['header_image'] ?? ''),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Stack(
                            children: [
                              Image.network(
                                game?['header_image'] ?? '',
                              ),
                            ],
                          ),
                          title: Text(game?['name'] ?? '', style: TextStyle(color: Colors.white)),
                          //subtitle: Text(gameID['appid'].toString(), style: TextStyle(color: Colors.white)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Text(game?['name'] ?? '', style: TextStyle(color: Colors.white)),
                              Text(
                                  game != null && game['publishers'] != null ?
                                  '${game['publishers']}'
                                      : '',
                                  style: TextStyle(color: Colors.white)
                              ),
                              SizedBox(height: 3),
                              Text(
                                  game != null && game['price_overview'] != null ?
                                  'Prix : ${game['price_overview']['final_formatted']}'
                                      : 'Prix : Gratuit',
                                  style: TextStyle(color: Colors.white)
                              ),

                            ],
                          ),
                          trailing: Text('En savoir plus', style: TextStyle(color: Colors.white)),
                          isThreeLine: true,
                        ),
                      );*/


                    },
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
//TODO CORS headers
/* , headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE"

    }*/

/*Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                Image.network(
                  'https://cdn.akamai.steamstatic.com//steam//apps/'
                      '/346110//ss_2fd997a2f7151cb2187043a1f41589cc6a9ebf3a.1920x1080.jpg?t=1669254188',
                  width: 500,
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Exemple de texte',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Les meilleures ventes",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
                decorationThickness: 1,
                decorationStyle: TextDecorationStyle.solid,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _mpGamesID.length,
              itemBuilder: (context, index) {
                final gameID = _mpGamesID[index];
                final game = _mpGame[gameID['appid']];
                return ListTile(
                  leading: Stack(
                    children: [
                      Image.network(
                        game?['header_image'] ?? '',
                      ),
                    ],
                  ),
                  title: Text(game?['name'] ?? '', style: TextStyle(color: Colors.white)),
                  subtitle: Text(gameID['appid'].toString(), style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ), */

/*body: ListView.builder(
        itemCount: _mpGamesID.length,
        itemBuilder: (context, index) {
          final gameID = _mpGamesID[index];
          final game = _mpGame[gameID['appid']];
          //final gameName = _mpGame[gameID['appid']]?['name'] ?? '';
          //fetchGameDetails(gameID['appid']);
          return ListTile(
            leading: Stack(
              children: [
                Image.network(
                  game?['header_image'] ?? '',
                ),
              ],
            ),
            title: Text(game?['name'] ?? '', style: TextStyle(color: Colors.white)),
            //title: Text(gameID['rank'].toString(), style: TextStyle(color: Colors.white)),
            subtitle: Text(gameID['appid'].toString(), style: TextStyle(color: Colors.white)),
          );
        },
      ),*/

///////////////////////////////////////////////////////////////////



/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String searchText = "";

  List<String> data = [];
  List<String> filteredData = [];

  final String steamApiUrl = "https://api.steampowered.com/ISteamApps/GetAppList/v2/";
  //https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?key=B7ABBB155FF3A1AE5A0EFB9D78A7FCDE
  Future<List<String>> fetchSteamGames() async {
    final response = await http.get(Uri.parse(steamApiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> gamesList = json.decode(response.body)["applist"]["apps"];
      final List<String> games = gamesList.map((game) => game["name"] as String).toList();
      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSteamGames().then((games) {
      setState(() {
        data = games;
        filteredData = data;
      });
    });
  }

  void filterSearchResults(String query) {
    List<String> searchResult = [];
    if (query.isNotEmpty) {
      data.forEach((game) {
        if (game.toLowerCase().contains(query.toLowerCase())) {
          searchResult.add(game);
        }
      });
      setState(() {
        filteredData = searchResult;
      });
    } else {
      setState(() {
        filteredData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search Games",
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            searchText = value;
            filterSearchResults(searchText);
          },
        ),
      ),
      body: Center(
        child: filteredData.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(filteredData[index]),
                  );
                },
              ),
      ),
    );
  }
}*/

/* FONCTIONNE //=========================================
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SteamGameList extends StatefulWidget {
  @override
  _SteamGameListState createState() => _SteamGameListState();
}

class _SteamGameListState extends State<SteamGameList> {
  List<dynamic> _games = [];

  Future<void> _fetchGames() async {
    final response = await http.get(Uri.parse('https://cors-anywhere.herokuapp.com/'
        'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/'
        '?key=B7ABBB155FF3A1AE5A0EFB9D78A7FCDE'));
    //https://api.steampowered.com/ISteamApps/GetAppList/v2/?key=B7ABBB155FF3A1AE5A0EFB9D78A7FCDE

    if (response.statusCode == 200) {
      //On limite a 10 résultats
      final List<dynamic> gamesList = jsonDecode(response.body)['response']['ranks'].take(10).toList();
      setState(() {
        _games = gamesList;
      });
    } else {
      throw Exception('Failed to fetch games from API');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de jeux Steam'),
      ),
      body: ListView.builder(
        itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];
          return ListTile(
            title: Text(game['rank'].toString()),
            subtitle: Text(game['appid'].toString()),
          );
        },
      ),
    );
  }
}
*/

















/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<dynamic> gamesList = [];
  List<String> games = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    getGamesList();
  }

  void getGamesList() async {
    final response = await http.get(Uri.parse('https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?format=json&limit=10?key=B7ABBB155FF3A1AE5A0EFB9D78A7FCDE'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> gamesData = jsonDecode(response.body);
      setState(() {
        gamesList = gamesData['response']['games'];
        games = gamesList.map((game) => game['name'] as String).toList();
      });
    } else {
      throw Exception('Failed to load games list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Steam Games'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search games',
                ),
                onChanged: (value) {
                  setState(() {
                    searchTerm = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  if (games[index].toLowerCase().contains(searchTerm)) {
                    return ListTile(
                      title: Text(games[index]),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

/* TODO
* import 'dart:convert';
import 'package:http/http.dart' as http;

Future searchGame(String gameName) async {
  final response = await http.get(Uri.parse('https://api.steampowered.com/ISteamApps/GetAppList/v2/'));

  if (response.statusCode == 200) {
    final games = json.decode(response.body)['applist']['apps'];

    // Filter the games by the name
    final filteredGames = games.where((game) => game['name'].toLowerCase().contains(gameName.toLowerCase()));

    return filteredGames;
  } else {
    throw Exception('Failed to load games');
  }
}
 */