class User{
  int id;
  String name;
  String email;
  String phone;
  String avatar;

  User({required this.id ,required this.name, required this.email, required this.phone, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
    };
  }
}