import 'package:firebase_auth/firebase_auth.dart';
import 'package:testfluttr1/models/user.dart';
import 'package:testfluttr1/services/database.dart';

class AuthentificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    initUser(user);
    return user != null ? AppUser(user.uid) : null;
  }

  void initUser(User? user) async {
    if (user == null) return;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  /*
  Future<Stream<AppUser?>> get user async {
    return await FirebaseAuth.instance.authStateChanges().map(_userFromFirebaseUser);
  }

  Stream<AppUser?>? _userStream;

  Future<void> initUserStream() async {
    _userStream = await getUserStream();
  }

  Future<Stream<AppUser?>> getUserStream() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(user.uid) : null;
  }*/


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user == null) {
        throw Exception("No user found");
      } else {
        await DatabaseService(user.uid).addUser(name);
      }
        return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

}