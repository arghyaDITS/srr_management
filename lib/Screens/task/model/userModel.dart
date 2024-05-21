class Users {
  final String name;
  final int id;

  Users({required this.name, required this.id});
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
    );
  }
}