class User {
  final int id;
  final String token;

  User({required this.id, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: int.parse(json['id'].toString()), token: json['token']);
  }
}
