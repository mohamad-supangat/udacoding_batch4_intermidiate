class User {
  int id;
  String name;
  String username;
  String email;
  String photo;
  String password;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.photo,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    photo = json['photo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }

    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['password'] = this.password;

    return data;
  }
}
