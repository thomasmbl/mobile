class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final List<dynamic> likes;
  final List<dynamic> wishlist;

  AppUserData({required this.uid, required this.name, required this.likes, required this.wishlist});
}